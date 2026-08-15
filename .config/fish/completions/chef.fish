# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_chef_global_optspecs
    string join \n units= override-units no-default-units no-extensions all-extensions compat-extensions e/extensions= warnings-as-errors ignore-warnings color= path= no-recipe-ref-check max-depth= debug-trace config= h/help V/version
end

function __fish_chef_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_chef_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_chef_using_subcommand
    set -l cmd (__fish_chef_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c chef -n "__fish_chef_needs_command" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_needs_command" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_needs_command" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_needs_command" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_needs_command" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_needs_command" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_needs_command" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_needs_command" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_needs_command" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_needs_command" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_needs_command" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_needs_command" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_needs_command" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_needs_command" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_needs_command" -l debug-trace
complete -c chef -n "__fish_chef_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_needs_command" -s V -l version -d 'Print version'
complete -c chef -n "__fish_chef_needs_command" -f -a "recipe" -d 'Read a recipe'
complete -c chef -n "__fish_chef_needs_command" -f -a "r" -d 'Read a recipe'
complete -c chef -n "__fish_chef_needs_command" -f -a "list" -d 'List all the recipes'
complete -c chef -n "__fish_chef_needs_command" -f -a "ls" -d 'List all the recipes'
complete -c chef -n "__fish_chef_needs_command" -f -a "serve" -d 'Recipes web server'
complete -c chef -n "__fish_chef_needs_command" -f -a "shopping-list" -d 'Creates a shopping list from a given list of recipes'
complete -c chef -n "__fish_chef_needs_command" -f -a "sl" -d 'Creates a shopping list from a given list of recipes'
complete -c chef -n "__fish_chef_needs_command" -f -a "units" -d 'List loaded units'
complete -c chef -n "__fish_chef_needs_command" -f -a "convert" -d 'Convert values to other units'
complete -c chef -n "__fish_chef_needs_command" -f -a "c" -d 'Convert values to other units'
complete -c chef -n "__fish_chef_needs_command" -f -a "config" -d 'See loaded configuration'
complete -c chef -n "__fish_chef_needs_command" -f -a "collection" -d 'Manage the recipe collection'
complete -c chef -n "__fish_chef_needs_command" -f -a "generate-completions" -d 'Generate shell completions'
complete -c chef -n "__fish_chef_needs_command" -f -a "new" -d 'Create a new recipe'
complete -c chef -n "__fish_chef_needs_command" -f -a "edit" -d 'Edit an existing recipe'
complete -c chef -n "__fish_chef_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l name -d 'Give or override a name for the recipe' -r
complete -c chef -n "__fish_chef_using_subcommand recipe" -s o -l output -d 'Output file, none for stdout' -r
complete -c chef -n "__fish_chef_using_subcommand recipe" -s f -l format -d 'Output format' -r -f -a "human\t''
json\t''
cooklang\t''
markdown\t''"
complete -c chef -n "__fish_chef_using_subcommand recipe" -s s -l scale -d 'Scale to a number of servings' -r
complete -c chef -n "__fish_chef_using_subcommand recipe" -s c -l convert -d 'Convert to a unit system' -r -f -a "metric\t''
imperial\t''"
complete -c chef -n "__fish_chef_using_subcommand recipe" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand recipe" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand recipe" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand recipe" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand recipe" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand recipe" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand recipe" -l pretty -d 'Pretty output format, if available'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l events -d 'Debug output as events'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l ast -d 'Debug output as AST'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l check -d 'Check the recipe for errors, warnings and images'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand recipe" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand recipe" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand r" -l name -d 'Give or override a name for the recipe' -r
complete -c chef -n "__fish_chef_using_subcommand r" -s o -l output -d 'Output file, none for stdout' -r
complete -c chef -n "__fish_chef_using_subcommand r" -s f -l format -d 'Output format' -r -f -a "human\t''
json\t''
cooklang\t''
markdown\t''"
complete -c chef -n "__fish_chef_using_subcommand r" -s s -l scale -d 'Scale to a number of servings' -r
complete -c chef -n "__fish_chef_using_subcommand r" -s c -l convert -d 'Convert to a unit system' -r -f -a "metric\t''
imperial\t''"
complete -c chef -n "__fish_chef_using_subcommand r" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand r" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand r" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand r" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand r" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand r" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand r" -l pretty -d 'Pretty output format, if available'
complete -c chef -n "__fish_chef_using_subcommand r" -l events -d 'Debug output as events'
complete -c chef -n "__fish_chef_using_subcommand r" -l ast -d 'Debug output as AST'
complete -c chef -n "__fish_chef_using_subcommand r" -l check -d 'Check the recipe for errors, warnings and images'
complete -c chef -n "__fish_chef_using_subcommand r" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand r" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand r" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand r" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand r" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand r" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand r" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand r" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand r" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand r" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand list" -s t -l tag -d 'Filter entries by tag' -r
complete -c chef -n "__fish_chef_using_subcommand list" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand list" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand list" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand list" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand list" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand list" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand list" -s c -l check -d 'Check recipes for correctness'
complete -c chef -n "__fish_chef_using_subcommand list" -s i -l images -d 'Include images'
complete -c chef -n "__fish_chef_using_subcommand list" -s T -l tags -d 'Show tags in the list'
complete -c chef -n "__fish_chef_using_subcommand list" -s l -l long -d 'Add `check` and `images` in one flag'
complete -c chef -n "__fish_chef_using_subcommand list" -s p -l paths -d 'Display the relative path of the recipes'
complete -c chef -n "__fish_chef_using_subcommand list" -s P -l absolute-paths -d 'Display the absolute path of the recipes'
complete -c chef -n "__fish_chef_using_subcommand list" -s n -l count -d 'Only count the number of recipes'
complete -c chef -n "__fish_chef_using_subcommand list" -s f -l force -d 'Force to list recipes even outside a collection'
complete -c chef -n "__fish_chef_using_subcommand list" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand list" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand list" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand list" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand list" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand list" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand list" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand list" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand list" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand ls" -s t -l tag -d 'Filter entries by tag' -r
complete -c chef -n "__fish_chef_using_subcommand ls" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand ls" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand ls" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand ls" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand ls" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand ls" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand ls" -s c -l check -d 'Check recipes for correctness'
complete -c chef -n "__fish_chef_using_subcommand ls" -s i -l images -d 'Include images'
complete -c chef -n "__fish_chef_using_subcommand ls" -s T -l tags -d 'Show tags in the list'
complete -c chef -n "__fish_chef_using_subcommand ls" -s l -l long -d 'Add `check` and `images` in one flag'
complete -c chef -n "__fish_chef_using_subcommand ls" -s p -l paths -d 'Display the relative path of the recipes'
complete -c chef -n "__fish_chef_using_subcommand ls" -s P -l absolute-paths -d 'Display the absolute path of the recipes'
complete -c chef -n "__fish_chef_using_subcommand ls" -s n -l count -d 'Only count the number of recipes'
complete -c chef -n "__fish_chef_using_subcommand ls" -s f -l force -d 'Force to list recipes even outside a collection'
complete -c chef -n "__fish_chef_using_subcommand ls" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand ls" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand ls" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand ls" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand ls" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand ls" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand ls" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand ls" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand ls" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand ls" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand serve" -l port -d 'Set http server port' -r
complete -c chef -n "__fish_chef_using_subcommand serve" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand serve" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand serve" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand serve" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand serve" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand serve" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand serve" -l host -d 'Allow external connections'
complete -c chef -n "__fish_chef_using_subcommand serve" -l disable-open-editor -d 'Disable the open editor functionality in the server'
complete -c chef -n "__fish_chef_using_subcommand serve" -l open -d 'Open browser on start'
complete -c chef -n "__fish_chef_using_subcommand serve" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand serve" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand serve" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand serve" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand serve" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand serve" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand serve" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand serve" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand serve" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand serve" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -s o -l output -d 'Output file, none for stdout' -r
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -s f -l format -d 'Output format' -r -f -a "human\t''
json\t''"
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -s a -l aisle -d 'Load aisle conf file' -r
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -s p -l plain -d 'Do not display categories'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l pretty -d 'Pretty output format, if available'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand shopping-list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand sl" -s o -l output -d 'Output file, none for stdout' -r
complete -c chef -n "__fish_chef_using_subcommand sl" -s f -l format -d 'Output format' -r -f -a "human\t''
json\t''"
complete -c chef -n "__fish_chef_using_subcommand sl" -s a -l aisle -d 'Load aisle conf file' -r
complete -c chef -n "__fish_chef_using_subcommand sl" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand sl" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand sl" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand sl" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand sl" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand sl" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand sl" -s p -l plain -d 'Do not display categories'
complete -c chef -n "__fish_chef_using_subcommand sl" -l pretty -d 'Pretty output format, if available'
complete -c chef -n "__fish_chef_using_subcommand sl" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand sl" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand sl" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand sl" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand sl" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand sl" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand sl" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand sl" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand sl" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand sl" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand units" -l system -d 'Filter by unit system' -r -f -a "metric\t''
imperial\t''
none\t''"
complete -c chef -n "__fish_chef_using_subcommand units" -l quantity -d 'Filter by physical quantity' -r -f -a "volume\t''
mass\t''
length\t''
temperature\t''
time\t''"
complete -c chef -n "__fish_chef_using_subcommand units" -s s -l sort -d 'Sort results. Can be specified multiple times' -r -f -a "system\t''
physical-quantity\t''
ratio\t''
best\t''"
complete -c chef -n "__fish_chef_using_subcommand units" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand units" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand units" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand units" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand units" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand units" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand units" -s l -l long -d 'More data'
complete -c chef -n "__fish_chef_using_subcommand units" -s a -l all -d 'Show all names/symbols, not just the first'
complete -c chef -n "__fish_chef_using_subcommand units" -s n -l count -d 'Show unit count only'
complete -c chef -n "__fish_chef_using_subcommand units" -l dump -d 'Writes all units in json format, one per line along with conversion data'
complete -c chef -n "__fish_chef_using_subcommand units" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand units" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand units" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand units" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand units" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand units" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand units" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand units" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand units" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand units" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand convert" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand convert" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand convert" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand convert" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand convert" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand convert" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand convert" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand convert" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand convert" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand convert" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand convert" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand convert" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand convert" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand convert" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand convert" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand convert" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand c" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand c" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand c" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand c" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand c" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand c" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand c" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand c" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand c" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand c" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand c" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand c" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand c" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand c" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand c" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand c" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand config" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand config" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand config" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand config" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand config" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand config" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand config" -l setup -d 'Run the basic interactive config setup'
complete -c chef -n "__fish_chef_using_subcommand config" -l chef -d 'Display the chef config, common to all collections'
complete -c chef -n "__fish_chef_using_subcommand config" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand config" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand config" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand config" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand config" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand config" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand config" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand config" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand config" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand config" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -f -a "new" -d 'Create a new recipe collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -f -a "set" -d 'Set the default collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -f -a "get" -d 'Get the default collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -f -a "unset" -d 'Removes the default collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and not __fish_seen_subcommand_from new set get unset help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l copy-config -d 'Copy the default config into the local `config.toml` file'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l set-default
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l force -d 'Forces the creation of the collection even if it\'s not empty'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from set" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from unset" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from help" -f -a "new" -d 'Create a new recipe collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from help" -f -a "set" -d 'Set the default collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get the default collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from help" -f -a "unset" -d 'Removes the default collection'
complete -c chef -n "__fish_chef_using_subcommand collection; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand generate-completions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand new" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand new" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand new" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand new" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand new" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand new" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand new" -s E -l no-edit -d 'Skip opening the editor'
complete -c chef -n "__fish_chef_using_subcommand new" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand new" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand new" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand new" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand new" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand new" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand new" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand new" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand new" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand edit" -l units -d 'A units TOML file' -r
complete -c chef -n "__fish_chef_using_subcommand edit" -s e -l extensions -d 'Enable a set of extensions' -r
complete -c chef -n "__fish_chef_using_subcommand edit" -l color -d 'Controls when to use color' -r -f -a "auto\t''
always\t''
never\t''"
complete -c chef -n "__fish_chef_using_subcommand edit" -l path -d 'Change the base path' -r -f -a "(__fish_complete_directories)"
complete -c chef -n "__fish_chef_using_subcommand edit" -l max-depth -d 'Override recipe indexing depth' -r
complete -c chef -n "__fish_chef_using_subcommand edit" -l config -d 'Use a specific configuration fileignoring the expected path' -r
complete -c chef -n "__fish_chef_using_subcommand edit" -l override-units -d 'Make the `units` arg remove the other file(s)'
complete -c chef -n "__fish_chef_using_subcommand edit" -l no-default-units -d 'Do not use the bundled units'
complete -c chef -n "__fish_chef_using_subcommand edit" -l no-extensions -d 'Disable all extensions'
complete -c chef -n "__fish_chef_using_subcommand edit" -l all-extensions -d 'Enable all extensions'
complete -c chef -n "__fish_chef_using_subcommand edit" -l compat-extensions -d 'Enables a subset of the extensions'
complete -c chef -n "__fish_chef_using_subcommand edit" -l warnings-as-errors -d 'Treat warnings as errors'
complete -c chef -n "__fish_chef_using_subcommand edit" -l ignore-warnings -d 'Do not display warnings generated from parsing recipes'
complete -c chef -n "__fish_chef_using_subcommand edit" -l no-recipe-ref-check -d 'Skip checking if referenced recipes exist'
complete -c chef -n "__fish_chef_using_subcommand edit" -l debug-trace
complete -c chef -n "__fish_chef_using_subcommand edit" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "recipe" -d 'Read a recipe'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "list" -d 'List all the recipes'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "serve" -d 'Recipes web server'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "shopping-list" -d 'Creates a shopping list from a given list of recipes'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "units" -d 'List loaded units'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "convert" -d 'Convert values to other units'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "config" -d 'See loaded configuration'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "collection" -d 'Manage the recipe collection'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "generate-completions" -d 'Generate shell completions'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "new" -d 'Create a new recipe'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "edit" -d 'Edit an existing recipe'
complete -c chef -n "__fish_chef_using_subcommand help; and not __fish_seen_subcommand_from recipe list serve shopping-list units convert config collection generate-completions new edit help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c chef -n "__fish_chef_using_subcommand help; and __fish_seen_subcommand_from collection" -f -a "new" -d 'Create a new recipe collection'
complete -c chef -n "__fish_chef_using_subcommand help; and __fish_seen_subcommand_from collection" -f -a "set" -d 'Set the default collection'
complete -c chef -n "__fish_chef_using_subcommand help; and __fish_seen_subcommand_from collection" -f -a "get" -d 'Get the default collection'
complete -c chef -n "__fish_chef_using_subcommand help; and __fish_seen_subcommand_from collection" -f -a "unset" -d 'Removes the default collection'
