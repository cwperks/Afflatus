module JobsHelper

  # Bad name, but get's comma separated list of names for category, location
  # and level
  def get_comma_separated_list_of_names(the_list)
    the_string = ''
    return the_string if the_list.nil?
    the_list.each do |item|
      the_string << item['name'] + ','
    end
    the_string[0..-2]
  end
end
