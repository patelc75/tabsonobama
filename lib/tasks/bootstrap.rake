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
    require 'active_record/fixtures'
    # TODO: after all in yaml format, use Dir.glob(RAILS_ROOT + '/db/fixtures/*.yml')
    fixture_files = %w{ weekly_radio_addresses cabinet_members }.collect do |f| 
      "#{RAILS_ROOT}/db/fixtures/#{f}.yml"
    end
    fixture_files.each do |file|
      Fixtures.create_fixtures('db/fixtures', File.basename(file, '.*'))
    end
  end
  
  task :setup => [:bootstrap, :seed, :campaign_promises]
end