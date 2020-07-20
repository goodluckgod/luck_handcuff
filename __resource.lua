resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'luckHandCuff'

version '1.3.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua'
}

dependencies {
	'es_extended'
}