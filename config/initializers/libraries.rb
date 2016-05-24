require 'exceptions'

# Load all core extensions
Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each { |file| require file }