"""
Script : NAME

"""
extends Node

# Signals

# Export variable

# Public variables
var sentence: Array = ["Aliquam volutpat quam at condimentum gravida", "Nullam eget nisl commodo, ultricies lorem lobortis, ornare enim", "Maecenas a lacus consequat mauris porta tempus", "Nunc pharetra neque in dolor ullamcorper, nec accumsan mi tincidunt", "Nunc aliquam tortor et arcu elementum, nec rhoncus tortor blandit", "Aliquam mollis ipsum condimentum arcu luctus pellentesque", "Donec eleifend lorem non orci eleifend gravida", "Vivamus eget elit aliquam, imperdiet urna eu, tincidunt tellus", "Maecenas feugiat tortor eu tellus feugiat, et aliquet est egestas", "Curabitur pulvinar tortor et ultricies placerat", "Nullam vitae enim ut sem eleifend consequat sit amet vitae nunc", "Praesent eget est non tellus suscipit pulvinar", "Morbi aliquet libero id tortor interdum ultrices", "Ut malesuada quam sit amet odio porta tristique", "Sed quis diam consequat, eleifend ipsum gravida, condimentum elit", "Etiam et dolor eu nibh vehicula luctus a sed mauris", "Pellentesque tempus erat sit amet neque molestie, non ultricies sapien cursus", "Maecenas condimentum nunc faucibus arcu faucibus imperdiet", "Nam aliquet nibh in tellus ornare efficitur", "Fusce luctus lorem sit amet mauris egestas, id semper felis semper", "Fusce tincidunt turpis ut luctus volutpat", "Ut aliquet augue eu dapibus lobortis", "Pellentesque interdum massa eget aliquet molestie", "Etiam vel urna sit amet purus fermentum dictum", "Nam posuere sapien pretium tellus facilisis, nec dapibus lacus ullamcorper", "Curabitur consequat magna ac turpis semper rhoncus", "Suspendisse finibus sapien at consectetur ultrices", "Nulla sit amet sapien et augue faucibus dictum", "Ut consequat nisi vel tellus tristique, maximus rutrum libero mollis", "Aliquam blandit augue at sapien interdum, at luctus arcu porta", "Fusce ultricies est ut nunc lobortis vulputate", "Aliquam nec urna non purus molestie imperdiet in vel nisi", "Nullam eget sapien porta, ornare tellus et, condimentum sapien", "Nunc egestas dui sit amet ipsum auctor dapibus", "Maecenas ac sapien nec urna maximus rutrum non et est", "Etiam gravida mi imperdiet, rhoncus tortor et, luctus tortor", "Maecenas eget diam rhoncus mauris vehicula vehicula", "Vestibulum bibendum dui in odio tincidunt, sit amet porttitor sapien ultrices", "Suspendisse at nisi varius, luctus ex eget, iaculis purus", "Integer posuere ligula ac nunc fringilla feugiat", "Ut sit amet risus eu massa sagittis sagittis", "Pellentesque laoreet arcu eu congue consectetur", "Curabitur suscipit enim vel ullamcorper mattis"]
var paragraph: Array = ["Vestibulum justo ante, euismod vel condimentum vel, ultrices ac augue. Integer tempus auctor diam sed luctus. Suspendisse potenti. Fusce accumsan, ipsum a bibendum sodales, lacus libero laoreet dui, in semper orci velit ac mi. Nunc sed tellus in purus auctor consequat vel vitae enim. Quisque tristique pretium lectus, in laoreet sem dapibus quis. Nullam semper finibus tellus, at interdum orci varius at. Sed ultricies vulputate lorem quis eleifend. Duis suscipit nisl id turpis tristique lobortis. Quisque condimentum a nisl et aliquet. Maecenas vel maximus massa.", "Aliquam fringilla feugiat magna, ac egestas elit ullamcorper sit amet. Curabitur nec arcu efficitur, ultrices erat id, ultrices sapien. Morbi viverra vel tortor ut dapibus. In maximus urna a leo dapibus, faucibus faucibus massa vehicula. Quisque vestibulum ut tellus vel ultrices. Vestibulum ac libero id metus pharetra consequat vulputate quis massa. In id rhoncus dui, a tempus diam.", "Proin at pulvinar massa. Vestibulum egestas et tellus ac auctor. Donec egestas volutpat tellus, in pulvinar risus commodo ut. Nam nisi augue, blandit eu posuere faucibus, porttitor nec ante. Vestibulum sagittis tellus sed urna ullamcorper sodales. Mauris non iaculis elit, sagittis dictum metus. Donec in erat ut tortor tristique porta vitae ut magna. Donec in nisi non nunc ornare tincidunt. Maecenas quis ligula id nunc convallis euismod id eget tortor.", "In ipsum turpis, lacinia ac venenatis at, placerat et diam. Curabitur porttitor lacus lectus, ac accumsan orci pulvinar a. Quisque imperdiet odio enim, et vehicula urna tincidunt in. Pellentesque et orci aliquam, tempus lectus et, viverra ipsum. Phasellus non condimentum quam. Integer et ante sed purus iaculis euismod. Nunc id leo eu elit elementum iaculis ac eget massa. Mauris consectetur vulputate dui sit amet porttitor. Sed interdum tincidunt erat nec consectetur. Cras et fringilla erat, sed finibus magna.", "Morbi a tincidunt neque. Pellentesque tempor orci et leo cursus, in feugiat nunc consequat. Etiam rhoncus tincidunt nisl, ut ultrices elit rutrum quis. In hac habitasse platea dictumst. Curabitur id est neque. Nunc pellentesque scelerisque faucibus. Fusce ultricies finibus malesuada. Pellentesque ac ex vitae turpis efficitur dignissim eget et velit. Sed varius ultricies velit. Suspendisse potenti.", "Curabitur pharetra tellus at tortor mollis, non commodo odio interdum. Vivamus lobortis vel nibh ut malesuada. Maecenas urna nulla, consequat et dolor ac, fringilla varius turpis. Nullam quam purus, varius non lorem sed, venenatis facilisis nulla. Proin convallis interdum leo ut viverra. Sed condimentum sem vel est lacinia, rutrum molestie turpis suscipit. Nulla pretium aliquet neque, in elementum magna feugiat eget. Nunc nibh nibh, porta id tellus a, cursus congue enim. Aenean euismod vitae orci non feugiat. Cras lectus nulla, luctus non augue nec, auctor tincidunt urna. Integer in dolor metus. Sed et odio sed elit porta varius. Quisque tristique nunc at turpis cursus, sed tincidunt nibh pharetra.", "Praesent viverra consectetur magna, quis gravida mauris congue a. Sed a varius risus. Aenean a enim est. Morbi sit amet tincidunt tortor. Morbi id interdum ante, sit amet blandit purus. Integer condimentum fermentum lectus, a ornare ante condimentum a. Pellentesque rutrum vehicula laoreet. Quisque nunc eros, eleifend sed felis eu, dictum laoreet ipsum. Donec tempor vel diam eget viverra. Interdum et malesuada fames ac ante ipsum primis in faucibus.", "Integer sed molestie neque. Etiam faucibus pharetra blandit. Aliquam finibus diam vehicula nunc faucibus interdum. Nulla non nunc nec sem molestie malesuada. Nam non elit vitae erat viverra feugiat ut accumsan ex. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque nec erat sit amet magna tincidunt ultricies et vel justo.", "Aenean risus sapien, ultricies at ex finibus, blandit condimentum orci. Duis dictum, nibh ut sodales consectetur, purus urna feugiat turpis, quis tincidunt eros ipsum eu leo. Integer nisl lorem, interdum rhoncus leo nec, commodo ultrices neque. Morbi et metus mattis, consequat urna a, placerat tellus. Nam in aliquet mi, id gravida risus. Phasellus ut nisl eget lectus convallis placerat at ut velit. Aenean interdum ultricies ipsum ac commodo. Aliquam erat volutpat. Vivamus felis nunc, laoreet et augue ut, posuere tincidunt diam. Mauris lacinia leo mi, eu mattis mi mattis vel. In vulputate tincidunt sem, quis tincidunt magna gravida vitae.", "Mauris dictum sed quam eget vehicula. Ut viverra pretium porttitor. Fusce id efficitur tortor. Suspendisse tempor elit ligula, eu ullamcorper augue tincidunt in. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Praesent varius imperdiet facilisis. Curabitur ullamcorper accumsan leo, quis luctus neque tristique ut. Maecenas imperdiet erat sed urna mattis congue. Nam molestie felis non hendrerit imperdiet. Pellentesque tellus lacus, imperdiet nec venenatis vel, efficitur nec justo. Ut imperdiet dui vitae leo ullamcorper faucibus.", "Maecenas vitae massa volutpat, ultrices felis ut, commodo diam. Ut elit magna, tincidunt porttitor quam at, elementum sagittis diam. Integer sit amet eros vitae dolor imperdiet malesuada. Sed gravida erat quis tortor malesuada aliquam. Vivamus vehicula nunc vel sapien consectetur, in tincidunt erat tristique. Morbi eleifend quis ante a maximus. Aenean tristique mollis ipsum a suscipit. Donec pharetra porttitor ipsum, eget laoreet orci vestibulum eu. Maecenas tempor tellus eu pharetra finibus. In non mauris et massa dapibus cursus. Praesent malesuada mollis nulla, vitae porttitor nisi malesuada in.", "Nulla iaculis eu quam vel tristique. Phasellus efficitur rhoncus tortor non consectetur. Curabitur sodales erat a ultricies tristique. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Vivamus gravida imperdiet sodales. Proin tincidunt leo non neque tempus malesuada. Aenean finibus elit mollis tellus auctor gravida. Aenean varius ante sed tempus laoreet. Morbi et fringilla risus. Ut tincidunt neque eu ipsum blandit lacinia."]
var word: Array = ["Vestibulum", "vitae", "sem", "ut", "nunc", "rutrum", "ullamcorper", "in", "eu", "erat.", "Vestibulum", "ac", "justo", "molestie,", "dapibus", "metus", "eu,", "interdum", "arcu.", "Vestibulum", "sodales", "arcu", "nec", "neque", "sodales,", "id", "consectetur", "sapien", "consectetur.", "Aliquam", "sed", "hendrerit", "turpis.", "Praesent", "id", "sapien", "rhoncus,", "facilisis", "ligula", "ultrices,", "venenatis", "augue.", "Mauris", "laoreet", "rhoncus", "nulla,", "at", "dictum", "ligula", "sollicitudin"]


# Onready variables


# Setter Getter Functions

# Callback functions

# Self functions
func _ready():
	randomize()	
	for i in range(20):
		RecipesManager.add_recipe_doc(generate_random_recipe())
		yield(RecipesManager, "request_finished")


func get_rand_word() -> String:
	return word[randi() % word.size()]
	

func get_rand_sentence() -> String:
	return sentence[randi() % sentence.size()]


func get_rand_paragraph() -> String:
	return paragraph[randi() % paragraph.size()]


func get_rand_ingredients() -> Array:
	var list: Array = []
	for i in range(randi() % 10 + 2):
		var ing = {}
		ing.quantity = randi() % 500 + 1
		ing.ingredient = get_rand_word()
		list.append(ing)
	
	return list
	
	

func generate_random_recipe() -> Array:
	var recipe: Array = []
	recipe.append({"id": "title", "content": get_rand_sentence()})
	recipe.append({"id": "photo_id", "content": String(rand_range(0.0, 10000.0))})
	recipe.append({"id": "category", "content": randi() % 5})
	recipe.append({"id": "season", "content": "001100101000"})
	recipe.append({"id": "diet", "content": randi() % 3})
	recipe.append({"id": "quality", "content": randi() % 2})
	recipe.append({"id": "portions", "content": (randi() % 8) + 1})
	recipe.append({"id": "prep_time", "content": [randi() % 3, randi() % 60]})
	recipe.append({"id": "cook_time", "content": [randi() % 3, randi() % 60]})
	recipe.append({"id": "gluten_free", "content": bool(randi() % 2)})
	recipe.append({"id": "milk_free", "content": bool(randi() % 2)})
	recipe.append({"id": "with_sugar", "content": bool(randi() % 2)})
	recipe.append({"id": "ingredients", "content": get_rand_ingredients()})
	recipe.append({"id": "instructions", "content": get_rand_paragraph()})
	
	return recipe

# Signal functions
