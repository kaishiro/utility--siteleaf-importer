require "siteleaf"
require "json"

# API settings
Siteleaf.api_key = ''
Siteleaf.api_secret = ''

# site settings
site_id = ''
page_id = ''
test_mode = false # change to true to test your import

# get entries from JSON dump
contents = JSON.parse(File.read("blog.json"))

# loop through and add entries
contents.each do |content|
  puts "Creating post..."
  
  # set up post
  post = Siteleaf::Post.new

  post.site_id = site_id

  post.parent_id = page_id
  
  # required
  post.title = content["title"]
  post.body = content["body"]
  
  # optional
  post.taxonomy = [
    {"key" => "Tags", "values" => content["tags"]}
  ]
  post.published_at = content["published_at"]
  
  # save
  puts test_mode ? post.inspect : post.save.inspect
end

# done!
puts "Success!"
