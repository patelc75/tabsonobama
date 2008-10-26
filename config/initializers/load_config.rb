#GLOBAL_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/settings.yml")[:global].symbolize_keys
APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/settings.yml")[RAILS_ENV].symbolize_keys
