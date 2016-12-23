require 'net/http'
require 'json'

class JobsController < ApplicationController

  MUSE_API_URL = 'https://api-v2.themuse.com/jobs'
  API_KEY = 'd46f707a798be0f5d9176416475e9a4700f0d515f26df799119bbee08b3041d6'

  def index
  end

  def search
    @jobs_filter = Job.new
    if !params['job'].nil?
      @jobs_filter.company = params['job']['company']
      @jobs_filter.categories = []
      params['job']['categories'].each do |category|
        @jobs_filter.categories << category unless category.blank?
      end
      @jobs_filter.levels = []
      params['job']['levels'].each do |level|
        @jobs_filter.levels << level unless level.blank?
      end
      @jobs_filter.locations = params['job']['locations']
      # params['job']['locations'].each do |location|
      #   @jobs_filter.locations << location unless location.blank?
      # end
    end

    @levels = [
      'Internship',
      'Entry Level',
      'Mid Level',
      'Senior Level'
    ]

    @categories = [
      'Account Management',
      'Business & Strategy',
      'Creative & Design',
      'Customer Service',
      'Data Science',
      'Editorial',
      'Education',
      'Engineering',
      'Finance',
      'Fundraising & Development',
      'Healthcare & Medicine',
      'HR & Recruiting',
      'Legal',
      'Marketing & PR',
      'Operations',
      'Project & Product Management',
      'Retail Sales',
      'Social Media & Community'
    ]

    # puts "#{MUSE_API_URL}?api_key=#{API_KEY}&page=0"

    if @jobs_filter.is_empty
      uri = URI.parse("#{MUSE_API_URL}?api_key=#{API_KEY}&page=0")
    else
      unparsed_uri = "#{MUSE_API_URL}?api_key=#{API_KEY}&page=0"
      unparsed_uri << "&company=#{@jobs_filter.company}" unless @jobs_filter.company.nil?
      @jobs_filter.categories.each do |category|
        unparsed_uri << "&category=#{category}" unless category.blank?
      end
      @jobs_filter.levels.each do |level|
        unparsed_uri << "&level=#{level}" unless level.blank?
      end
      uri = URI.parse(unparsed_uri)
      @has_filter = true
    end
    response = Net::HTTP.get(uri)
    @jobs_data = JSON.parse(response)

    @total = @jobs_data['total']
    @results = @jobs_data['results']
  end

  def clear
    redirect_to jobs_search_path
  end

end
