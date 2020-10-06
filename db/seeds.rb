[
  %w[Bevétel wallet],
  %w[Egészség medkit],
  %w[Egyéb receipt],
  %w[Étel restaurant],
  %w[Háztartás trash-bin],
  %w[Közlekedés subway],
  %w[Kütyük hardware-chip],
  %w[Lakás home],
  %w[Ruházat shirt],
  %w[Szépségápolás flower],
  %w[Szórakozás game-controller]
].each do |category_params|
  Category.find_or_create_by(name: category_params.first, key: category_params.second)
end
