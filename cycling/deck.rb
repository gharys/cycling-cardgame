require 'squib'
require 'game_icons'
require 'game_icons/icon'

image_text_size_8 = 36
image_text_size_12 = 50

$snippets = Hash.new(0)
File.open("card_texts.txt", "r") do |f|
  text = ""
  label = "{}"
  f.each_line do |line|
    if (line.start_with? "==") and (line.end_with? "==\n")
      $snippets[label] = text
      label = "{"+line[2..-4]+"}"
      text = ""
    else
      text = text + line
    end
  end
  $snippets[label] = text
end

$sprint = GameIcons.get("liberty-wing").
                recolor(fg: '222', bg: 'fff').string                                
$climb = GameIcons.get("mountaintop").
                recolor(fg: '00f', bg_opacity: 0).string                                
$stamina = GameIcons.get("hearts").
                recolor(fg: 'f00', bg_opacity: 0).string                                
$exhaust = GameIcons.get("heart-minus").
                recolor(fg: 'e0e', bg_opacity: 0).string                                
$skill = GameIcons.get("detour").
                recolor(fg: '0b0', bg_opacity: 0).string                                
$d1 = GameIcons.get("dice-six-faces-one").
                recolor(fg: '000', bg: 'fff').string
$d2 = GameIcons.get("dice-six-faces-two").
                recolor(fg: '000', bg: 'fff').string                                
$d3 = GameIcons.get("dice-six-faces-three").
                recolor(fg: '000', bg: 'fff').string                                
$d4 = GameIcons.get("dice-six-faces-four").
                recolor(fg: '000', bg: 'fff').string                                
$d5 = GameIcons.get("dice-six-faces-five").
                recolor(fg: '000', bg: 'fff').string                                
$d6 = GameIcons.get("dice-six-faces-six").
                recolor(fg: '000', bg: 'fff').string
$dany = GameIcons.get('perspective-dice-six-faces-random').
                recolor(fg: '000', bg_opacity: 0).string
$plus1d = GameIcons.get("perspective-dice-six-faces-five").
                recolor(fg: '000', bg_opacity: 0).string                                
$cycler_ = GameIcons.get("cycling").
                recolor(fg: '000', bg_opacity: 0).string                                
$cycler = GameIcons.get("cycling").
                recolor(fg: '000', bg: 'fff').string                                
$inf = GameIcons.get("infinity").
                recolor(fg: '000', bg_opacity: 0).string                                
$phase1 = GameIcons.get("private").string                                
$phase2 = GameIcons.get("corporal").string                                
$phase3 = GameIcons.get("sergeant").string                                
$finale = GameIcons.get("checkered-flag").string                                
$flat =  GameIcons.get("road").string
$hills =  GameIcons.get("hills").string
$mountains =  GameIcons.get("mountains").string
$hand = GameIcons.get("hand").
                            recolor(fg: '000', bg_opacity: 0).string
$bullet = GameIcons.get("play-button").
                            recolor(fg: '000', bg_opacity: 0).string
$vslow = IO.read("icons/vslow.svg")
$slow = IO.read("icons/slow.svg")
$brisk = IO.read("icons/brisk.svg")
$fast = IO.read("icons/fast.svg")
$vfast = IO.read("icons/vfast.svg")
$speedbase = IO.read("icons/speed-base.svg")
$size = IO.read("icons/size.svg")
#$helmet = IO.read("icons/helmet.svg")
$group =  IO.read("icons/group.svg")
                                                
def images(embed, size)
  embed.svg key: ':sprint:', data: $sprint, width: size, height: size
  embed.svg key: ':climb:', data: $climb, width: size, height: size
  embed.svg key: ':stamina:', data: $stamina, width: size, height: size
  embed.svg key: ':exhaust:', data: $exhaust, width: size, height: size
  embed.svg key: ':skill:', data: $skill, width: size, height: size
  embed.svg key: ':d1:', data: $d1, width: size, height: size
  embed.svg key: ':d2:', data: $d2, width: size, height: size
  embed.svg key: ':d3:', data: $d3, width: size, height: size
  embed.svg key: ':d4:', data: $d4, width: size, height: size
  embed.svg key: ':d5:', data: $d5, width: size, height: size
  embed.svg key: ':d6:', data: $d6, width: size, height: size
  embed.svg key: ':d?:', data: $dany, width: size, height: size
  embed.svg key: ':+1d:', data: $plus1d, width: size, height: size
  embed.svg key: ':cycler:', data: $cycler, width: size, height: size
  embed.svg key: ':cycler_:', data: $cycler_, width: size, height: size
  embed.svg key: ':p1:', data: $phase1, width: size, height: size
  embed.svg key: ':p2:', data: $phase2, width: size, height: size
  embed.svg key: ':p3:', data: $phase3, width: size, height: size
  embed.svg key: ':finale:', data: $finale, width: size, height: size
  embed.svg key: ':flat:', data: $flat, width: size, height: size
  embed.svg key: ':hills:', data: $hills, width: size, height: size
  embed.svg key: ':mountains:', data: $mountains, width: size, height: size
  embed.svg key: ':vslow:', data: $vslow, width: size, height: size
  embed.svg key: ':slow:', data: $slow, width: size, height: size
  embed.svg key: ':brisk:', data: $brisk, width: size, height: size
  embed.svg key: ':fast:', data: $fast, width: size, height: size
  embed.svg key: ':vfast:', data: $vfast, width: size, height: size
  embed.svg key: ':speed-base:', data: $speedbase, width: size, height: size
  embed.svg key: ':size:', data: $size, width: size, height: size
  embed.svg key: ':group:', data: $group, width: size, height: size
  embed.svg key: ':inf:', data: $inf, width: size, height: size
end

def text_sub(str)
  if str.nil?
    return ""
  elsif str.is_a? String
    str.gsub! /<br>/, "\n"
    $snippets.each{ |k, v| str.sub!(k, v) }
    return str
  else
    return str
  end
end

def speed_sub(str)
  if str == "vfast"
    return $vfast
  elsif str == "fast"
    return $fast
  elsif str == "brisk"
    return $brisk
  elsif str == "slow"
    return $slow
  elsif str == "vslow"
    return $vslow
  else
    return $speedbase
  end
end

data = Squib.csv file: 'cyclists.csv'
data['text'].each { |s| text_sub(s) }
# data['stamina'].each { |s| text_sub(s) }

Squib::Deck.new cards: data['name'].size, layout: 'cyclist_layout.yml',
                width: 825, height: 1125 do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  text str: data['name'], layout: 'title'
  # svg data: $cycler, layout: 'bonus1'
  text(str: data['text'], layout: 'description', markup: true)   { |e| images(e, image_text_size_8) }
  text(str: " :stamina: stamina", layout: 'bonus2', font: 'Arial 8')  { |e| images(e, 42) }
  text(str: data['stamina'], layout: 'bonus2', font: 'Arial 12', valign: 'middle', align: 'center') { |e| images(e, 48) }
  text(str: " :sprint: sprint", layout: 'bonus3', font: 'Arial 8')  { |e| images(e, 42) }
  text str: data['sprint'], layout: 'bonus3', font: 'Arial 12', valign: 'middle', align: 'center'
  text(str: " :climb: climb", layout: 'bonus4', font: 'Arial 8')  { |e| images(e, 42) }
  text str: data['climb'], layout: 'bonus4', font: 'Arial 12', valign: 'middle', align: 'center'
  text(str: " :skill: skill", layout: 'bonus5', font: 'Arial 8')  { |e| images(e, 42) }
  text str: data['skill'], layout: 'bonus5', font: 'Arial 12', valign: 'middle', align: 'center'
  png file: data['art'], layout: 'art' 
  save_png prefix: "cyclist_"
end

data = Squib.csv file: 'groups.csv'
data['text'].each { |s| text_sub(s) }
data['speed'].map! { |s| speed_sub(s) }

Squib::Deck.new cards: data['name'].size, layout: 'group_layout.yml',
                width: 825, height: 1125 do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  text str: data['name'], layout: 'title'
  text(str: data['text'], layout: 'description', markup: true)   { |e| images(e, image_text_size_8) }
  text(str: " :stamina: stamina", layout: 'bonus2', font: 'Arial 8')  { |e| images(e, 42) }
  text(str: data['stamina'], layout: 'bonus2', font: 'Arial 12', valign: 'middle', align: 'center') { |e| images(e, 48) }
  text(str: " :sprint: sprint", layout: 'bonus3', font: 'Arial 8')  { |e| images(e, 42) }
  text str: data['sprint'], layout: 'bonus3', font: 'Arial 12', valign: 'middle', align: 'center'
  text(str: " :climb: climb", layout: 'bonus4', font: 'Arial 8')  { |e| images(e, 42) }
  text str: data['climb'], layout: 'bonus4', font: 'Arial 12', valign: 'middle', align: 'center'
  text(str: " :size: size", layout: 'bonus5', font: 'Arial 8')  { |e| images(e, 42) }
  text str: data['size'], layout: 'bonus5', font: 'Arial 12', valign: 'middle', align: 'center'
  svg data: data['speed'], layout: 'bonus1', height: :scale
  png file: data['art'], layout: 'art' 
  save_png prefix: "group_"
end

data = Squib.csv file: 'stage_phase.csv'
data['text'].each { |s| text_sub(s) }
data['icon'].map! { |str| GameIcons.get(str).string }
data['phase'].map! { |str| GameIcons.get(str).string }

Squib::Deck.new cards: data['title'].size, layout: 'stage_phase_layout.yml',
              width: 825, height: 1125 do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter
  
  text str: data['title'], layout: 'title'
  text(str: data['text'], layout: 'description', markup: true)   { |e| images(e, image_text_size_8) }
  text str: data['type'], layout: 'type'
  svg data: data['icon'], layout: 'lower_left'
  svg data: data['phase'], layout: 'lower_right'
  png file: data['art'], layout: 'art' 
  save_png prefix: "phase_"
end
              


for event_type in ['vslow'] do
  
  data = Squib.csv file: "events-#{event_type}.csv"
  data['heading'].each { |s| text_sub(s) }
  data['description'].each { |s| text_sub(s) }
  data['pickup'].each { |s| text_sub(s) }
  pcolors = Array.new(data["heading"].size(), "#fff")
  for i in (0...pcolors.length)
    s = data['player'][i]
    if s.nil?
      pcolors[i] = '#fff'
    elsif s.start_with? "{c"
      pcolors[i] = '#fde'
    elsif s.start_with? "{nc"
      pcolors[i] = '#2F2'
    else
      pcolors[i] = '#fde'
    end
  end
  
  Squib::Deck.new cards: data['heading'].size, layout: 'event_layout.yml',
                width: 825, height: 1125 do
    background color: 'white'
    rect layout: 'cut' # cut line as defined by TheGameCrafter
    rect layout: 'safe' # safe zone as defined by TheGameCrafter
    
    text str: data["title"], layout: 'title'
    rect layout: 'heading', fill_color: 'yellow', stroke_color: 'yellow'
    text(str: data['heading'], layout: 'heading', markup: true)   { |e| images(e, image_text_size_12) }
    rect layout: 'player', fill_color: pcolors, stroke_color: pcolors
    text(str: data['player'], layout: 'player', markup: true)   { |e| images(e, image_text_size_12) }
    text(str: data['description'], layout: 'description', markup: true)   { |e| images(e, image_text_size_8) }
    rect layout: 'extrabox'
    svg data: $hand, layout: 'icon'
    svg file: "icons/#{event_type}.svg", layout: 'lower_right', height: :scale
    text(str: data['pickup'], layout: 'extra', markup: true)   { |e| images(e, image_text_size_8) }
    save_png prefix: "event_#{event_type}_"
  end
end


data = Squib.csv file: 'backgrounds.csv'
Squib::Deck.new cards: data['art'].size, layout: 'background_layout.yml',
            width: 825, height: 1125 do
  background color: 'white'
  rect layout: 'cut' # cut line as defined by TheGameCrafter
  rect layout: 'safe' # safe zone as defined by TheGameCrafter

  png file: data['art'], layout: 'art'
  save_png prefix: "bg_"
end
