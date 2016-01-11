module ShoutboxesHelper

  def nested_shoutboxes(shoutboxes)
    shoutboxes.map do |message, sub_shoutboxes|
      render(message) + content_tag(:div, nested_shoutboxes(sub_shoutboxes), :class => "nested_shoutboxes")
    end.join.html_safe
  end
end