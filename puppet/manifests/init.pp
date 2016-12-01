exec { 'apt-get update':
	path => '/usr/bin',
}

package { 'vim':
	ensure => present,
}

package { 'git':
	ensure => present,
}

package { 'apache2':
	ensure => purged,
}

file { '/var/www/':
	ensure => 'directory',
}

include nginx, php, mysql
