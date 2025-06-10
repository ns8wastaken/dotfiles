local M = {
    usage_file = nil,
    usage_last_file = nil,
    mode = nil
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

-- Update usage time
function M.update_usage()
    local after = os.time()
    local before = M.read_number(M.usage_last_file)
    local usage = M.read_number(M.usage_file)
    if before > 0 and after > before then
        usage = usage + (after - before)
        M.write_number(M.usage_file, usage)
    end
    M.write_number(M.usage_last_file, after)
end

-- Format time into hours, minutes, seconds
function M.format_time(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format(
        'You have %d hour%s, %d minute%s, and %d second%s on Neovim.',
        hours,   hours   == 1 and '' or 's',
        minutes, minutes == 1 and '' or 's',
        secs,    secs    == 1 and '' or 's'
    )
end

-- Display usage
function M.display_usage()
    M.update_usage()
    local usage = M.read_number(M.usage_file)
    local usage_text = M.format_time(usage)

    if M.mode == 'print' then
        print(usage_text)
    elseif M.mode == 'notify' then
        vim.notify(usage_text)
    else -- float
        local width = #usage_text
        local height = 1
        local row = math.floor(vim.o.lines / 2 - height / 2)
        local col = math.floor(vim.o.columns / 2 - width / 2)

        -- Create buffer
        local buf = vim.api.nvim_create_buf(false, true)
        local win_opts = {
            relative = 'editor',
            row      = row,
            col      = col,
            width    = width,
            height   = height,
            style    = 'minimal',
            border   = 'rounded'
        }

        -- Open float window
        local win = vim.api.nvim_open_win(buf, true, win_opts)
        vim.api.nvim_buf_set_lines(buf, 0, -1, true, { usage_text })
        vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

        -- Hide cursor
        vim.cmd("silent hi Cursor blend=100")
        local cursor_opts = vim.api.nvim_get_option_value('guicursor', { scope = 'global' })
        vim.api.nvim_set_option_value('guicursor', 'a:Cursor/lCursor', { scope = 'global' })

        -- Allow quitting just by pressing `q`
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })

        -- Timer for real-time updates
        local update_timer = vim.loop.new_timer()
        update_timer:start(1000, 1000, vim.schedule_wrap(function()
            if not vim.api.nvim_win_is_valid(win) then
                update_timer:stop()
                update_timer:close()
                return
            end
            M.update_usage()
            usage = M.read_number(M.usage_file)
            usage_text = M.format_time(usage)
            vim.api.nvim_set_option_value('modifiable', true, { buf = buf })
            vim.api.nvim_buf_set_lines(buf, 0, -1, true, { usage_text })
            vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
            -- Update window width if text length changes
            if #usage_text ~= width then
                width = #usage_text
                win_opts.width = width
                win_opts.col = math.floor(vim.o.columns / 2 - width / 2)
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_set_config(win, win_opts)
                end
            end
        end))

        local augroup = vim.api.nvim_create_augroup('Usage', { clear = true })
        vim.api.nvim_create_autocmd('BufLeave', {
            buffer = buf,
            callback = function()
                update_timer:stop()
                update_timer:close()
                vim.api.nvim_buf_delete(buf, { force = true })
                vim.api.nvim_del_augroup_by_id(augroup)
                -- Reset cursor
                vim.cmd("hi Cursor blend=0")
                vim.api.nvim_set_option_value('guicursor', cursor_opts, { scope = 'global' })
            end
        })
    end
end

function M.setup(opts)
    opts = opts or {}
    M.usage_file = vim.fn.stdpath('data') .. '/usage/usage'
    M.usage_last_file = vim.fn.stdpath('data') .. '/usage/usage_last'
    M.mode = opts.mode or 'float' -- float, print, notify
    local timer_interval = (opts.timer_interval_s * 1000) or 60000 -- ms, default 1min

    -- Ensure directory exists
    local usage_dir = vim.fn.stdpath('data') .. '/usage'
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

    -- Timer-based updates
    local timer = vim.loop.new_timer()
    timer:start(0, timer_interval, vim.schedule_wrap(M.update_usage))

    -- Reset timestamp on focus gain (AFK return)
    vim.api.nvim_create_autocmd('FocusGained', {
        callback = function()
            local now = os.time()
            local last = M.read_number(M.usage_last_file)
            if now - last > 300 then -- Ignore if < 5min AFK
                M.write_number(M.usage_last_file, now)
            end
        end
    })

    -- Final update on exit
    vim.api.nvim_create_autocmd('VimLeave', {
        callback = M.update_usage
    })

    -- Create :Usage command
    vim.api.nvim_create_user_command('Usage', M.display_usage, { bang = false })
end

return M
