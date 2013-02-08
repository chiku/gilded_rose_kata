# A sample Guardfile
# More info at https://github.com/guard/guard#readme

notification :growl

guard 'rake', :task => 'spec' do
  watch(%r{\.rb$})
  notification :growl
end