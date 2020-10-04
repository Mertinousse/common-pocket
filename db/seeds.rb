%w[
  Bevétel
  Egészség 
  Egyéb
  Étel 
  Háztartás
  Közlekedés 
  Kütyük 
  Lakás 
  Ruházat
  Szépségápolás
  Szórakozás 
].each do |category|
  Category.find_or_create_by(name: category)
end
