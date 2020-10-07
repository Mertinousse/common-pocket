module ApplicationHelper
  def permanent
    {
      'data-reflex-permanent': true,
      id: "permanent-#{SecureRandom.uuid}"
    }
  end
end
