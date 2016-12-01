# vagrant/puppet/modules/php/manifests/init.pp
class php {


	$phpPackages = [
		'php5-fpm', 
		'php5-cli', 
		'php-apc', 
		'php5-curl', 
		'php5-gd', 
		'php5-mcrypt', 
		'php5-mysql', 
		'php5-xcache',
		'gearman-job-server',
		'php5-gearman',
		'php-mail', 
		'ntp'
	]

	# Install the php dependencies
	package { $phpPackages:
		ensure => present,
		require => Exec['apt-get update'],
	}

	# Make sure php5-fpm is running
	service { 'php5-fpm':
		ensure => running,
		require => Package['php5-fpm'],
	}

	# Add our own php file (short tag enabled is only difference)
	file { 'vagrant-php-ini':
		path => '/etc/php5/fpm/php.ini',
		ensure => file,
		require => Package['php5-fpm'],
		source => 'puppet:///modules/php/php.ini',
	}

	# Add our own www.conf to correct listen port
	file { 'vagrant-php-www':
		path => '/etc/php5/fpm/pool.d/www.conf',
		ensure => file,
		require => Package['php5-fpm'],
		source => 'puppet:///modules/php/www.conf',
		notify => Service['php5-fpm'],
	}

}
