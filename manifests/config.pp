class bdii::config (
  $log_level            = $bdii::log_level,
  $port                 = $bdii::port,
  $user                 = $bdii::user,
  $slapdconf            = $bdii::slapdconf,
  $slapdloglevel        = $bdii::slapdloglevel,
  $slapdthreads         = $bdii::slapdthreads,
  $deletedelay          = $bdii::deletedelay,
  $ramsize              = $bdii::ramsize,
  $template_config      = $bdii::template_config,
  $template_slapd       = $bdii::template_slapd,
  $template_sysconfig   = $bdii::template_sysconfig,
) inherits ::bdii {

      Class[bdii::install] -> Class[bdii::config]

      file {$slapdconf:
        content  => template($template_slapd),
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        notify   => Class['bdii::service'],
      }

      file {'/etc/bdii/bdii.conf':
        content  => template($template_config),
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        notify   => Class['bdii::service'],
      }

      file { '/etc/bdii/gip':
        ensure   => 'directory',
        owner    => 'root',
        group    => 'root',
        mode     => '0755',
      }

      file { '/var/lib/bdii/db':
        ensure   => 'directory',
        owner    => 'ldap',
        group    => 'ldap',
        mode     => '0755',
      }

      file {'/etc/sysconfig/bdii':
        content  => template($template_sysconfig),
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        notify   => Class['bdii::service'],
      }
}
