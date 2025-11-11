local M = {
    usage_file = nil,       -- Total accumulated time
    usage_last_file = nil,  -- Time of last update
    mode = nil,
    timer = nil, -- Store timer for control
}

-- Utility to read file with error handling
function M.read_number(file)
    local ok, lines = pcall(vim.fn.readfile, file)
    if not ok or not lines[1] or not tonumber(lines[1]) then
        return 0
    end
    return tonumber(lines[1])
end

-- Utility to write file with error handling
function M.write_number(file, value)
    pcall(vim.fn.writefile, { tostring(value) }, file)
end

-- Reset last usage timestamp
function M.reset_last_usage()
    M.write_number(M.usage_last_file, os.time())
end

-- Update usage time
function M.update_usage()
    local last_usage_time = M.read_number(M.usage_last_file)
    local total_usage = M.read_number(M.usage_file)
    local now = os.time()
    if last_usage_time > 0 and now > last_usage_time then
        total_usage = total_usage + (now - last_usage_time)
        M.write_number(M.usage_file, total_usage)
    end
    M.reset_last_usage()
end

-- Format time into hours, minutes, seconds
function M.format_time(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format(
        "You have %d hour%s, %d minute%s, and %d second%s on Neovim.",
        hours,   vim.g.ternary(hours   == 1, "", 's'),
        minutes, vim.g.ternary(minutes == 1, "", 's'),
        secs,    vim.g.ternary(secs    == 1, "", 's')
    )
end

-- Display usage
function M.display_usage()
    M.update_usage()
    local total_usage = M.read_number(M.usage_file)
    local total_usage_text = M.format_time(total_usage)

    if M.mode == "print" then
        print(total_usage_text)
        return
    elseif M.mode == "notify" then
        vim.notify(total_usage_text)
        return
    end

    local width = #total_usage_text
    local height = 1
    local row = math.floor(vim.o.lines / 2 - height / 2)
    local col = math.floor(vim.o.columns / 2 - width / 2)

    -- Create buffer
    local buf = vim.api.nvim_create_buf(false, true)
    local win_opts = {
        relative = "editor",
        row      = row,
        col      = col,
        width    = width,
        height   = height,
        style    = "minimal",
        border   = "rounded"
    }

    -- Open float window
    local win = vim.api.nvim_open_win(buf, true, win_opts)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, { total_usage_text })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

    -- Hide cursor
    vim.cmd("silent hi Cursor blend=100")
    local cursor_opts = vim.api.nvim_get_option_value("guicursor", { scope = "global" })
    vim.api.nvim_set_option_value("guicursor", "a:Cursor/lCursor", { scope = "global" })

    -- Allow quitting just by pressing `q`
    vim.keymap.set('n', 'q', "<cmd>close<cr>", { buffer = buf, silent = true })

    -- Timer for real-time updates
    local update_timer = vim.loop.new_timer()
    update_timer:start(1000, 1000, vim.schedule_wrap(function()
        if not vim.api.nvim_win_is_valid(win) then
            update_timer:stop()
            update_timer:close()
            return
        end

        M.update_usage()
        total_usage = M.read_number(M.usage_file)
        total_usage_text = M.format_time(total_usage)
        vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
        vim.api.nvim_buf_set_lines(buf, 0, -1, true, { total_usage_text })
        vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

        -- Update window width if text length changes
        if #total_usage_text ~= width then
            width = #total_usage_text
            win_opts.width = width
            win_opts.col = math.floor(vim.o.columns / 2 - width / 2)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_set_config(win, win_opts)
            end
        end
    end))

    -- Create autocmd to delete floating window when leaving/closing it
    local augroup = vim.api.nvim_create_augroup("Usage", { clear = true })
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = buf,
        group = augroup,
        callback = function()
            update_timer:stop()
            update_timer:close()
            vim.api.nvim_buf_delete(buf, { force = true })
            vim.api.nvim_del_augroup_by_id(augroup)
            -- Reset cursor
            vim.cmd("hi Cursor blend=0")
            vim.api.nvim_set_option_value("guicursor", cursor_opts, { scope = "global" })
        end
    })
end

function M.setup(opts)
    opts = opts or {}
    M.usage_file = vim.fn.stdpath("data") .. "/usage/usage"
    M.usage_last_file = vim.fn.stdpath("data") .. "/usage/usage_last"
    M.mode = opts.mode or "float" -- float, print, notify
    local timer_interval = (opts.timer_interval_s * 1000) or 60000 -- ms, default 1min

    -- Ensure directory exists
    local usage_dir = vim.fn.stdpath("data") .. "/usage"
    if vim.fn.isdirectory(usage_dir) == 0 then
        vim.fn.mkdir(usage_dir, 'p')
    end

    -- Initialize files if they don't exist
    if vim.fn.filereadable(M.usage_file) == 0 then
        M.write_number(M.usage_file, 0)
    end
    if vim.fn.filereadable(M.usage_last_file) == 0 then
        M.write_number(M.usage_last_file, os.time())
    end

    -- Set last usage to now
    M.reset_last_usage()

    -- Timer-based updates
    M.timer = vim.loop.new_timer()
    M.timer:start(0, timer_interval, vim.schedule_wrap(M.update_usage))

    -- Stop timer on focus lost
    vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
            if M.timer then
                M.timer:stop()
            end
        end
    })

    -- Resume timer on focus gained and reset timestamp
    vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
            local last = M.read_number(M.usage_last_file)
            if os.time() - last > 300 then -- Ignore if < 5min AFK
                M.reset_last_usage()
            end
            if M.timer then
                M.timer:start(0, timer_interval, vim.schedule_wrap(M.update_usage))
            end
        end
    })

    -- Final update on exit
    vim.api.nvim_create_autocmd("VimLeave", {
        callback = function()
            if M.timer then
                M.timer:stop()
                M.timer:close()
            end
            M.update_usage()
        end
    })

    -- Create :Usage command
    vim.api.nvim_create_user_command("Usage", M.display_usage, { bang = false })
end

return M
