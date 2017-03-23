DROP DATABASE IF EXISTS foodPlanner;
CREATE DATABASE foodPlanner;

\c foodplanner;

DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Cuisines;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS UserTypes;

CREATE TABLE UserTypes(
    utid SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE Users (
  uid SERIAL PRIMARY KEY,
  name TEXT,
  utid INT,
  FOREIGN KEY (utid) references UserTypes(utid)
);

-- CREATE TABLE User_N(
--     uid  INT PRIMARY KEY,
--     name     TEXT,
--     tid  INT,
--     );


CREATE TABLE Cuisine (
  cid SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE Recipe (
  rid SERIAL PRIMARY KEY,
  name TEXT,
  cid INT,
  instructions TEXT,
  FOREIGN KEY (cid) references Cuisine(cid)
);

CREATE TABLE Ingredient (
  iid SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE Ingredients_Recipes (
  iid INT,
  rid INT,
  measurement TEXT,
  PRIMARY KEY(iid, rid),
  FOREIGN KEY (iid) references Ingredient(iid),
  FOREIGN KEY (rid) references Recipe(rid));

INSERT INTO UserTypes (name)
  VALUES ('Regular');

INSERT INTO UserTypes (name)
  VALUES ('Admin');

INSERT INTO Cuisine (cid, name)
  VALUES (300, 'American');

INSERT INTO Cuisine (cid, name)
  VALUES (301, 'Italian');

INSERT INTO Cuisine (cid, name)
  VALUES (302, 'Chinese');

INSERT INTO Cuisine (cid, name)
  VALUES (303, 'Mexican');

INSERT INTO Cuisine (cid, name)
  VALUES (304, 'Indian');

INSERT INTO Cuisine (cid, name)
  VALUES (305, 'Japanese');

INSERT INTO Ingredient (iid, name)
VALUES (200, 'eggs');

INSERT INTO Ingredient (iid, name)
VALUES (201, 'cheese');

INSERT INTO Ingredient (iid, name)
VALUES (202, 'spinach');

INSERT INTO Ingredient (iid, name)
VALUES (203, 'tomato');

INSERT INTO Ingredient (iid, name)
VALUES (204, 'red bell pepper');

INSERT INTO Ingredient (iid, name)
VALUES (205, 'onion');

INSERT INTO Ingredient (iid, name)
VALUES (206, 'potato');

INSERT INTO Ingredient (iid, name)
VALUES (207, 'salt');

INSERT INTO Ingredient (iid, name)
VALUES (208, 'oil');

INSERT INTO Ingredient (iid, name)
VALUES (209, 'pepper');

INSERT INTO Ingredient (iid, name)
VALUES (210, 'capers');

INSERT INTO Ingredient (iid, name)
VALUES (211, 'lemon');

INSERT INTO Ingredient (iid, name)
VALUES (212, 'linguine');

INSERT INTO Ingredient (iid, name)
VALUES (213, 'sugar');

INSERT INTO Ingredient (iid, name)
VALUES (214, 'cinnamon');

INSERT INTO Ingredient (iid, name)
VALUES (215, 'flour');

INSERT INTO Ingredient (iid, name)
VALUES (216, 'milk');

INSERT INTO Ingredient (iid, name)
VALUES (217, 'vanilla extract');

INSERT INTO Ingredient (iid, name)
VALUES (218, 'mayonnaise');

INSERT INTO Ingredient (iid, name)
VALUES (219, 'black pepper');

INSERT INTO Ingredient (iid, name)
VALUES (220, 'bread');

INSERT INTO Ingredient (iid, name)
VALUES (221, 'butter');

INSERT INTO Ingredient (iid, name)
VALUES (222, 'scallops');

INSERT INTO Ingredient (iid, name)
VALUES (223, 'kale');

INSERT INTO Ingredient (iid, name)
VALUES (224, 'beef');

INSERT INTO Ingredient (iid, name)
VALUES (225, 'beef broth');

INSERT INTO Ingredient (iid, name)
VALUES (226, 'crackers');

INSERT INTO Ingredient (iid, name)
VALUES (227, 'bread crumbs');

INSERT INTO Ingredient (iid, name)
VALUES (228, 'eggplant');

INSERT INTO Ingredient (iid, name)
VALUES (229, 'chicken');

INSERT INTO Ingredient (iid, name)
VALUES (230, 'asparagus');

INSERT INTO Ingredient (iid, name)
VALUES (231, 'spaghetti sauce');

INSERT INTO Ingredient (iid, name)
VALUES (232, 'broccoli');

INSERT INTO Ingredient (iid, name)
VALUES (233, 'garlic');

INSERT INTO Ingredient (iid, name)
VALUES (234, 'carrot');

INSERT INTO Ingredient (iid, name)
VALUES (235, 'soy sauce');

INSERT INTO Ingredient (iid, name)
VALUES (236, 'taco seasoning');

INSERT INTO Ingredient (iid, name)
VALUES (237, 'rice');

INSERT INTO Ingredient (iid, name)
VALUES (238, 'lettuce');

INSERT INTO Ingredient (iid, name)
VALUES (239, 'prawns');

INSERT INTO Ingredient (iid, name)
VALUES (240, 'green beans');

INSERT INTO Ingredient (iid, name)
VALUES (241, 'coriander leaves');

INSERT INTO Ingredient (iid, name)
VALUES (242, 'rice wrappers');

INSERT INTO Ingredient (iid, name)
VALUES (243, 'spring onion');

INSERT INTO Ingredient (iid, name)
VALUES (244, 'miso paste');

INSERT INTO Ingredient (iid, name)
VALUES (245, 'chili paste');

INSERT INTO Ingredient (iid, name)
VALUES (246, 'curry paste');

INSERT INTO Ingredient (iid, name)
VALUES (247, 'shallot');

INSERT INTO Ingredient (iid, name)
VALUES (248, 'sardine');

INSERT INTO Ingredient (iid, name)
VALUES (249, 'seaweed');

INSERT INTO Ingredient (iid, name)
VALUES (250, 'strawberries');

INSERT INTO Ingredient (iid, name)
VALUES (251, 'mascarpone');

INSERT INTO Ingredient (iid, name)
VALUES (252, 'condensed milk');

INSERT INTO Ingredient (iid, name)
VALUES (253, 'cones');

INSERT INTO Ingredient (iid, name)
VALUES (254, 'sprinkles');

INSERT INTO Ingredient (iid, name)
VALUES (255, 'water');

INSERT INTO Ingredient (iid, name)
VALUES (256, 'tofu');

INSERT INTO Ingredient (iid, name)
VALUES (257, 'dark chocolate');

INSERT INTO Ingredient (iid, name)
VALUES (258, 'soured cream');

INSERT INTO Ingredient (iid, name)
VALUES (259, 'red chili');

INSERT INTO Ingredient (iid, name)
VALUES (260, 'cannellini beans');

INSERT INTO Ingredient (iid, name)
VALUES (261, 'butter beans ');

INSERT INTO Ingredient (iid, name)
VALUES (262, 'vinegar');

INSERT INTO Ingredient (iid, name)
VALUES (263, 'parsley');



INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (102, 'Omelet',300,
'Beat egg and egg whites in a small bowl. Mix in Parmesan cheese, Cheddar cheese, salt, red pepper flakes, garlic powder, nutmeg, and pepper.
Heat oil in a large skillet over medium heat; cook and stir mushrooms, green onion, and bell pepper until tender, about 5 minutes. Place spinach in skillet and cook until just wilted. Stir in diced tomato and egg mixture; as eggs set, lift edges, letting uncooked portion flow underneath. Cook until egg mixture sets, 10 to 15 minutes; cut into wedges and serve immediately.'
);

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (105, 'Egg Salad Sandwich' ,300,
'Place egg in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel and chop. Place the chopped eggs in a bowl, and stir in the mayonnaise, mustard and green onion. Season with salt, pepper and paprika. Stir and serve on your favorite bread or crackers.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (108, 'Hamburger Steak' ,300,
'In a large bowl, mix together the ground beef, egg, bread crumbs, pepper, salt, onion powder, garlic powder, and Worcestershire sauce. Form into 8 balls, and flatten into patties. Heat the oil in a large skillet over medium heat. Fry the patties and onion in the oil until patties are nicely browned, about 4 minutes per side. Remove the beef patties to a plate, and keep warm. Sprinkle flour over the onions and drippings in the skillet. Stir in flour with a fork, scraping bits of beef off of the bottom as you stir. Gradually mix in the beef broth and sherry. Season with seasoned salt. Simmer and stir over medium-low heat for about 5 minutes, until the gravy thickens. Turn heat to low, return patties to the gravy, cover, and simmer for another 15 minutes.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (111, 'Beef Stir-Fry' ,302,
'Heat vegetable oil in a large wok or skillet over medium-high heat; cook and stir beef until browned, 3 to 4 minutes. Move beef to the side of the wok and add broccoli, bell pepper, carrots, green onion, and garlic to the center of the wok. Cook and stir vegetables for 2 minutes. Stir beef into vegetables and season with soy sauce and sesame seeds. Continue to cook and stir until vegetables are tender, about 2 more minutes.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (114, 'Garlic Chicken' ,300,
'Melt butter in a large skillet over medium high heat. Add chicken and sprinkle with garlic powder, seasoning salt and onion powder. Saute about 10 to 15 minutes on each side, or until chicken is cooked through and juices run clear.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (116, 'Chicken Stirfry' ,302,
'Heat vegetable oil in a large wok or skillet over medium-high heat; cook and stir chicken until browned, 6 to 8 minutes. Move chicken to the side of the wok and add broccoli, bell pepper, carrots, green onion, and garlic to the center of the wok. Cook and stir vegetables for 2 minutes. Stir chicken into vegetables and season with soy sauce and sesame seeds. Continue to cook and stir until vegetables are tender, about 2 more minutes.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (118, 'Roasted Chicken and Vegetables in a Pan' ,300,
'Preheat oven to 500 degree F. Chop all the veggies into large pieces. In another cutting board chop the chicken into cubes. Place the chicken and veggies in a medium roasting dish or sheet pan. Add the olive oil, salt and pepper, italian seasoning, and paprika. Toss to combine. Bake for 15 minutes or until the veggies are charred and chicken is cooked. Enjoy with rice, pasta, or a salad.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (120, 'Chicken Vegetable Stew',300,
'In a large pot, put the chopped onion, chicken breast meat, carrots and potatoes. Add the salt and turmeric. Dissolve the tomato paste in water and add. If desired, add garlic powder and ground black pepper to season. Cook for 1 to 1 1/2 hours on medium low heat. Serve.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (124, 'Chicken & Vegetable Pasta',301,
'Cook linguine pasta according to package directions. Drain. Set aside; keep warm. Melt butter in 12-inch skillet until sizzling; add chicken, garlic and thyme. Cook over medium-high heat, stirring occasionally, 5-8 minutes or until chicken is no longer pink. Stir in vegetables. Continue cooking, stirring occasionally, 6-9 minutes or until vegetables are crisply tender. Stir in cooked fusilli and cheese.');

INSERT INTO Recipe (rid, name, cid, instructions)
VALUES (100, 'Chicken Fried Rice',302,
'In a small bowl, beat egg with water. Melt butter in a large skillet over medium low heat. Add egg and leave flat for 1 to 2 minutes. Remove from skillet and cut into shreds. Heat oil in same skillet; add onion and saute until soft. Then add rice, soy sauce, pepper and chicken. Stir fry together for about 5 minutes, then stir in egg. Serve hot.');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(200, 102, '4');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(201, 102, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(202, 102, '1 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(203, 102, '1/2 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(204, 102, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 102, '1/4 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208, 102, '1/2 teaspoon');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(200, 105, '8');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(218, 105, '1/2 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 105, '1/4 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(207, 105, 'to taste');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(219, 105, 'to taste');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(200, 108, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(224, 108, '1 pound, ground');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(219, 108, '1/8 teaspoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(207, 108, '1/2 teaspoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208, 108, '1 tablespoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 108, '1 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(215, 108, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(225, 108, '1 cup');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(224, 111, '1 pound, sirloin cut');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208, 111, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(232, 111, '1 1/2 cups');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(204, 111, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(234, 111, '2');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 111, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(235, 111, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(233, 111, '1 teaspoon, minced');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(221, 114, '3 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(229, 114, '4 skinless breasts');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(207, 114, '1 teaspoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(233, 114, '1 clove, chopped');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(224, 116, '1 pound, cubed');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208, 116, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(232, 116, '1 1/2 cups');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(204, 116, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(234, 116, '2');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 116, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(235, 116, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(233, 116, '1 teaspoon, minced');


INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(229, 118, '2 medium breasts');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(204, 118, '1 cup, chopped');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 118, '1/2 cup, chopped');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(232, 118, '1 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(203, 118, '1/2 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208, 118, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(207, 118, '1/2 teaspoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(219, 118, '1/2 teaspoon');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(229, 120, '2 boneless breasts');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 120, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(234, 120, '2');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(206, 120, '4');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(207, 120, '1/2 teaspoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(255, 120, '1/2 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(219, 120, '1/2 teaspoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(203, 120, 'paste form, 3 tablespoons');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(212, 124, '2 cups');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(221, 124, '1/4 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(229, 124, '1 pound skinless breasts');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(233, 124, '2 teaspoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(232, 124, '1/2 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(234, 124, '1/2 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(204, 124, '1/4 cup');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(200, 100, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(255, 100, '1 tablespoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208, 100, '1 tablespoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(205, 100, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(237, 100, '2 cups, cooked and cooled');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(235, 100, '2 tablespoons');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(219, 100, '1 teaspoon');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(229, 100, '1 cup, cooked');