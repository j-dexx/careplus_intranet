module ApplicationHelper
  
  def absolute_image_tag(*args)
    raw(image_tag(*args).sub /src="(.*?)"/, "src=\"http://#{ActionMailer::Base.default_url_options[:host]}" + '\1"')
  end
  
  def scan_for_links(text)
    result = ""
    for word in text.split(" ")
      if word.include?("http://") || word.include?("https://")
        result << link_to(word, word, :target => "_blank").to_s + " "
      elsif word.start_with?("#")
        result << link_to(word, "https://twitter.com/#{word}", :target => "_blank").to_s + " "
      elsif word.start_with?("@")
        result << link_to(word, "https://twitter.com/#{word[1..-1]}", :target => "_blank").to_s + " "
      else
        result << "#{word} "
      end
    end
    result
  end
  
  def email_scan_for_links(text)
    result = ""
    for word in text.split(" ")
      if word.include?("http://") || word.include?("https://")
        result << link_to(word, word, :target => "_blank", :style => "color: #f199b0; text-decoration: underline;").to_s + " "
      elsif word.start_with?("#")
        result << link_to(word, "https://twitter.com/#{word}", :target => "_blank", :style => "color: #f199b0; text-decoration: underline;").to_s + " "
      elsif word.start_with?("@")
        result << link_to(word, "https://twitter.com/#{word[1..-1]}", :target => "_blank", :style => "color: #f199b0; text-decoration: underline;").to_s + " "
      else
        result << "#{word} "
      end
    end
    result
  end
end
