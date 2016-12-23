require 'net/http'
require 'json'

class JobsController < ApplicationController

  MUSE_API_URL = 'https://api-v2.themuse.com/jobs'
  API_KEY = 'd46f707a798be0f5d9176416475e9a4700f0d515f26df799119bbee08b3041d6'

  def index
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

    # Set on first request, reset on clear
    @has_filter = false unless @has_filter = true

    @jobs_filter = Job.new

    puts "#{MUSE_API_URL}?api_key=#{API_KEY}&page=0"
    uri = URI.parse("#{MUSE_API_URL}?api_key=#{API_KEY}&page=0")
    response = Net::HTTP.get(uri)
    @jobs_data = JSON.parse(response)

    @total = @jobs_data['total']
    @results = @jobs_data['results']
  end

  def search
  end

  def clear
  end

end
