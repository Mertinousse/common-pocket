module ApplicationHelper
  def permanent
    {
      'data-reflex-permanent': true,
      'data-turbolinks-permanent': true,
      id: "permanent-#{SecureRandom.uuid}"
    }
  end
end
