require_relative '../rails_helper'

describe User do
  it { should have_many :repos }
  it { should have_many :repo_languages }
  it { should have_many :languages }  
end

describe User, '.find_or_create_from_omniauth' do

end

describe User, '.create_from_omniauth' do

end
