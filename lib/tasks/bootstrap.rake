namespace :app do
  task :bootstrap => [:environment] do
    
  end
  
  task :campaign_promises => [:environment] do
    yaml = YAML.load(File.open("#{RAILS_ROOT}/db/fixtures/campaign_promises.yml"))
    yaml[:issue_groups].each do |group|
      ig = IssueGroup.create({
        :name => group[:name], 
        :description => group[:description]
      })
      group[:issue_sections].each do |section|
        is = IssueSection.create({
          :name => section[:name], 
          :description => section[:description], 
          :issue_group => ig
        })
        section[:issue_bullets].each do |bullet|
          IssueBullet.create({
            :name => bullet[:name], 
            :description => bullet[:description], 
            :issue_section => is
          })
        end if section[:issue_bullets]
      end if group[:issue_sections]
    end if yaml[:issue_groups]
  end
  
  task :seed => :environment do
    %w{ weekly_radio_addresses cabinet_members }.collect do |table_name|
      file = "#{RAILS_ROOT}/db/fixtures/#{table_name}.yml"
      attribute_hashes = YAML.load(File.open(file))
      attribute_hashes.each do |key,values|
        table_name.camelize.singularize.constantize.create(values)
      end
    end
  end
  
  task :setup => [:bootstrap, :seed, :campaign_promises]
end