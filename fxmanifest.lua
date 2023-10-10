fx_version 'cerulean'
game 'gta5'

description 'QBX-FitBit'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/import.lua',
    '@qbx_core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

server_script 'server/main.lua'
client_script 'client/main.lua'

modules {
    'qbx_core:playerdata',
    'qbx_core:utils',
}

files {
    'html/*'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'