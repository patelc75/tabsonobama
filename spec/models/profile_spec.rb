require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Profile do

  describe 'validation' do
    
    describe 'allows legitimate first names:' do
      ['Andre The Giant (7\'4", 520 lb.) -- has a posse',
       '', '1234567890_234567890_234567890_234567890_234567890',
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            profile = create_profile(:first_name => name_str)
            profile.errors.on(:first_name).should be_nil
          end.should change(Profile, :count).by(1)
        end
      end
    end
    
    describe "disallows illegitimate first names" do
      ["tab\t", "newline\n",
       '1234567890_234567890_234567890_234567890_234567890_',
       ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            profile = create_profile(:first_name => name_str)
            profile.errors.on(:first_name).should_not be_nil
          end.should_not change(Profile, :count)
        end
      end
    end
    
    describe 'allows legitimate last names:' do
      ['Andre The Giant (7\'4", 520 lb.) -- has a posse',
       '', '1234567890_234567890_234567890_234567890_234567890',
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            profile = create_profile(:last_name => name_str)
            profile.errors.on(:last_name).should be_nil
          end.should change(Profile, :count).by(1)
        end
      end
    end
    
    describe "disallows illegitimate first names" do
      ["tab\t", "newline\n",
       '1234567890_234567890_234567890_234567890_234567890_',
       ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            profile = create_profile(:last_name => name_str)
            profile.errors.on(:last_name).should_not be_nil
          end.should_not change(Profile, :count)
        end
      end
    end
    
    it 'requires a zip code' do
      profile = create_profile(:zip => nil)
      profile.should_not be_valid
      profile.should have(1).error_on(:zip)
    end
    
    it 'requires a country code' do
      profile = create_profile(:country_code => nil)
      profile.should_not be_valid
      profile.should have(1).error_on(:country_code)
    end
    
  end
  
  protected
    def create_user(options = {})
      record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
      record.register! if record.valid?
      record
    end
    
    def create_affiliation(options={})
      attrs = {:name => 'PoliAff'}.merge(options)
      Affiliation.create(attrs)
    end
    
    def create_profile(options = {})
      attrs = {
        :first_name => 'quire',
        :last_name => 'quire',
        :affiliation => create_affiliation,
        :zip => '11202',
        :country_code => '1',
        :user => create_user
      }.merge(options)
      Profile.create(attrs)
    end
end