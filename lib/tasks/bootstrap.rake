namespace :app do
  task :bootstrap => [:environment] do
  end

  task :delete_campaign_promises => :environment do
    puts "Deleting " + "#{IssueGroup.count}" + " rows from #{IssueGroup.table_name}"
  	IssueGroup.delete_all()
    puts "Deleting " + "#{IssueSection.count}" + " rows from #{IssueSection.table_name}"
  	IssueSection.delete_all()
    puts "Deleting " + "#{IssueBullet.count}" + " rows from #{IssueBullet.table_name}"  	
    IssueBullet.delete_all()
  end

  task :delete_weekly_radio_addresses => :environment do
    puts "Deleting " + "#{WeeklyRadioAddress.count}" + " rows from #{WeeklyRadioAddress.table_name}"
  	WeeklyRadioAddress.delete_all()
  end

  task :delete_cabinet_members => :environment do
    puts "Deleting " + "#{CabinetMember.count}" + " rows from #{CabinetMember.table_name}"
  	CabinetMember.delete_all()
  end
  
  task :delete_ratings => :environment do
    puts "Deleting " + "#{Rating.count}" + " rows from #{Rating.table_name}"
  	Rating.delete_all()
  end
  
  task :delete_promotions => :environment do
    puts "Deleting " + "#{Promotion.count}" + " rows from #{Promotion.table_name}"
  	Promotion.delete_all()
  end
  
  task :load_campaign_promises => [:environment] do
    yaml = YAML.load(File.open("#{RAILS_ROOT}/db/fixtures/campaign_promises.yml"))
    puts "Loading " + "#{RAILS_ROOT}/db/fixtures/campaign_promises.yml"
    yaml[:issue_groups].each do |group|
      print group[:name]
      print ": "
      ig = IssueGroup.create({
        :name => group[:name], 
        :description => group[:description]
      })
      print group[:issue_sections].length if !group[:issue_sections].nil?
      print " sections, "
      bullet_count = 0
      group[:issue_sections].each do |section|
        is = IssueSection.create({
          :name => section[:name], 
          :description => section[:description], 
          :issue_group => ig
        })
        bullet_count = bullet_count + section[:issue_bullets].length if !section[:issue_bullets].nil?
        section[:issue_bullets].each do |bullet|
          IssueBullet.create({
            :name => bullet[:name], 
            :description => bullet[:description], 
            :short => bullet[:short],
            :issue_section => is,
            :issue_group => ig
          })
        end if section[:issue_bullets]
      end if group[:issue_sections]
      print bullet_count
      puts " bullets"
    end if yaml[:issue_groups]
    puts
  end

  def load_flat_yml_files(table_name)
    file = "#{RAILS_ROOT}/db/fixtures/#{table_name}.yml"
    puts "Loading " + "#{RAILS_ROOT}/db/fixtures/#{table_name}.yml"
    attribute_hashes = YAML.load(File.open(file))
    attribute_hashes.each do |key,values|
  	  puts key.to_s
      table_name.camelize.singularize.constantize.create(values)
    end
  end

  task :load_weekly_radio_addresses => :environment do
  	load_flat_yml_files("weekly_radio_addresses")
  	puts
  end

  task :load_cabinet_members => :environment do
  	load_flat_yml_files("cabinet_members")
  	puts
  end
  
  task :load_all => [:load_weekly_radio_addresses, :load_cabinet_members, :load_campaign_promises]
  
  task :delete_all => [:delete_weekly_radio_addresses, :delete_cabinet_members, :delete_campaign_promises, :delete_ratings, :delete_promotions]
  
  task :setup => [:bootstrap, :load_all]
end