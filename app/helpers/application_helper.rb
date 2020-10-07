module ApplicationHelper
  def permanent
    {
      'data-reflex-permanent': true,
      id: SecureRandom.uuid
    }
  end
end
