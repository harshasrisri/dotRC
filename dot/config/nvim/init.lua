local present, impatient = pcall(require, "impatient")
if not present then
    print("impatient not loaded yet")
end
require('settings')
require('mappings')
require('plugins')
