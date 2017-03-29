DROP DATABASE IF EXISTS foodPlanner;
CREATE DATABASE foodPlanner;

\c foodplanner;

DROP TABLE IF EXISTS UserTypes;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Cuisines;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS Ingredients_Recipes;
DROP TABLE IF EXISTS MealPlan_User;
DROP TABLE IF EXISTS MealPlan_Recipe;
DROP TABLE IF EXISTS Recipe_User;
DROP TABLE IF EXISTS User_ShoppingList;
DROP TABLE IF EXISTS ShoppingList_Ingredients;

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


CREATE TABLE Cuisines (
  cid SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE Recipes (
  rid SERIAL PRIMARY KEY,
  name TEXT,
  cid INT,
  instructions TEXT[],
  FOREIGN KEY (cid) references Cuisines(cid)

);

CREATE TABLE Ingredients (
  iid SERIAL PRIMARY KEY,
  name TEXT,
  price MONEY
);

CREATE TABLE Ingredients_Recipes (
  iid INT,
  rid INT,
  measurement TEXT,
  PRIMARY KEY(iid, rid),
  FOREIGN KEY (iid) references Ingredients(iid),
  FOREIGN KEY (rid) references Recipes(rid) ON DELETE CASCADE
  );

CREATE TABLE MealPlan_User(
    mid INT,
    uid INT NOT NULL,
    name TEXT,
    PRIMARY KEY (mid),
    FOREIGN KEY (uid) references Users(uid)
    );

CREATE TABLE MealPlan_Recipe(
    mid INT,
    rid INT,
    PRIMARY KEY (mid, rid),
    FOREIGN KEY (mid) references MealPlan_User(mid),
    FOREIGN KEY (rid) references Recipes(rid) ON DELETE CASCADE
    );

CREATE TABLE Recipe_User (
    uid INT,
    rid INT,
    PRIMARY KEY (uid, rid),
    FOREIGN KEY (uid) references Users(uid),
    FOREIGN KEY (rid) references Recipes(rid) ON DELETE CASCADE
    );

CREATE TABLE User_ShoppingList(
    uid INT NOT NULL,
    slid INT,
    PRIMARY KEY(slid),
    UNIQUE(slid),
    FOREIGN KEY (uid) references Users(uid));

CREATE TABLE ShoppingList_Ingredients(
    slid INT,
    iid INT,
    PRIMARY KEY(slid, iid),
    FOREIGN KEY (iid) references Ingredients(iid),
    FOREIGN KEY (slid) references User_ShoppingList(slid)
    );

--TRIGGERS FOR EACH TIME A NEW USER IS CREATED
CREATE FUNCTION meal_users() RETURNS trigger AS $$
    BEGIN
        IF NEW.utid IS NULL THEN
            RAISE EXCEPTION 'utid cannot be null';
        END IF;
        IF NEW.name IS NULL THEN
            RAISE EXCEPTION 'Name cannot be null';
        END IF;

        INSERT INTO mealplan_user(mid, uid, name) VALUES (NEW.uid+1000, NEW.uid, 'Breakfast');
        INSERT INTO mealplan_user(mid, uid, name) VALUES (NEW.uid+2000, NEW.uid, 'Lunch');
        INSERT INTO mealplan_user(mid, uid, name) VALUES (NEW.uid+3000, NEW.uid, 'Dinner');
        INSERT INTO mealplan_user(mid, uid, name) VALUES (NEW.uid+4000, NEW.uid, 'Snacks');

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER newplans_user
  AFTER INSERT
  ON users
  FOR EACH ROW
  EXECUTE PROCEDURE meal_users();


CREATE FUNCTION shoppinglist_user() RETURNS trigger AS $$
    BEGIN
        IF NEW.utid IS NULL THEN
            RAISE EXCEPTION 'utid cannot be null';
        END IF;
        IF NEW.name IS NULL THEN
            RAISE EXCEPTION 'Name cannot be null';
        END IF;

        INSERT INTO user_shoppinglist(uid,slid) VALUES (NEW.uid, NEW.uid+1000);

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER new_sl_user
  AFTER INSERT
  ON users
  FOR EACH ROW
  EXECUTE PROCEDURE shoppinglist_user();



INSERT INTO UserTypes (name)
  VALUES ('Regular');

INSERT INTO UserTypes (name)
  VALUES ('Admin');

INSERT INTO Users (name, utid)
    VALUES('admin', 2);

INSERT INTO Cuisines (cid, name)
  VALUES (300, 'American');

INSERT INTO Cuisines (cid, name)
  VALUES (301, 'Italian');

INSERT INTO Cuisines (cid, name)
  VALUES (302, 'Chinese');

INSERT INTO Cuisines (cid, name)
  VALUES (303, 'Mexican');

INSERT INTO Cuisines (cid, name)
  VALUES (304, 'Indian');

INSERT INTO Cuisines (cid, name)
  VALUES (305, 'Japanese');

INSERT INTO Ingredients (iid, name, price)
VALUES (200, 'eggs', 3.78);

INSERT INTO Ingredients (iid, name, price)
VALUES (201, 'cheese', 5.88);

INSERT INTO Ingredients (iid, name, price)
VALUES (202, 'spinach', 1.77);

INSERT INTO Ingredients (iid, name, price)
VALUES (203, 'tomato', 1.39);

INSERT INTO Ingredients (iid, name, price)
VALUES (204, 'red bell pepper', 2.10);

INSERT INTO Ingredients (iid, name, price)
VALUES (205, 'onion', 0.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (206, 'potato', 1.17);

INSERT INTO Ingredients (iid, name, price)
VALUES (207, 'salt', 3.49);

INSERT INTO Ingredients (iid, name, price)
VALUES (208, 'oil', 7.97);

INSERT INTO Ingredients (iid, name, price)
VALUES (209, 'pepper', 7.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (210, 'capers', 2.95);

INSERT INTO Ingredients (iid, name, price)
VALUES (211, 'lemon', 0.77);

INSERT INTO Ingredients (iid, name, price)
VALUES (212, 'linguine', 3.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (213, 'sugar', 3.27);

INSERT INTO Ingredients (iid, name, price)
VALUES (214, 'cinnamon', 2.29);

INSERT INTO Ingredients (iid, name, price)
VALUES (215, 'flour', 3.38);

INSERT INTO Ingredients (iid, name, price)
VALUES (216, 'milk', 2.37);

INSERT INTO Ingredients (iid, name, price)
VALUES (217, 'vanilla extract', 4.99);

INSERT INTO Ingredients (iid, name, price)
VALUES (218, 'mayonnaise', 3.97);

INSERT INTO Ingredients (iid, name, price)
VALUES (219, 'black pepper', 5.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (220, 'bread', 2.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (221, 'butter', 3.97);

INSERT INTO Ingredients (iid, name, price)
VALUES (222, 'scallops', 13.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (223, 'kale', 1.77);

INSERT INTO Ingredients (iid, name, price)
VALUES (224, 'beef', 16.59);

INSERT INTO Ingredients (iid, name, price)
VALUES (225, 'beef broth', 1.25);

INSERT INTO Ingredients (iid, name, price)
VALUES (226, 'crackers', 3.17);

INSERT INTO Ingredients (iid, name, price)
VALUES (227, 'bread crumbs', 2.99);

INSERT INTO Ingredients (iid, name, price)
VALUES (228, 'eggplant', 2.47);

INSERT INTO Ingredients (iid, name, price)
VALUES (229, 'chicken', 10.39);

INSERT INTO Ingredients (iid, name, price)
VALUES (230, 'asparagus', 3.86);

INSERT INTO Ingredients (iid, name, price)
VALUES (231, 'spaghetti sauce', 1.97);

INSERT INTO Ingredients (iid, name, price)
VALUES (232, 'broccoli', 2.97);

INSERT INTO Ingredients (iid, name, price)
VALUES (233, 'garlic', 0.99);

INSERT INTO Ingredients (iid, name, price)
VALUES (234, 'carrot', 1.68);

INSERT INTO Ingredients (iid, name, price)
VALUES (235, 'soy sauce', 2.88);

INSERT INTO Ingredients (iid, name, price)
VALUES (236, 'taco seasoning', 1.57);

INSERT INTO Ingredients (iid, name, price)
VALUES (237, 'rice', 4.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (238, 'lettuce', 1.78);

INSERT INTO Ingredients (iid, name, price)
VALUES (239, 'prawns', 14.34);

INSERT INTO Ingredients (iid, name, price)
VALUES (240, 'green beans', 4.99);

INSERT INTO Ingredients (iid, name, price)
VALUES (241, 'coriander leaves', 1.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (242, 'rice wrappers', 3.28);

INSERT INTO Ingredients (iid, name, price)
VALUES (243, 'spring onion', 0.57);

INSERT INTO Ingredients (iid, name, price)
VALUES (244, 'miso paste', 4.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (245, 'chili paste', 3.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (246, 'curry paste', 5.28);

INSERT INTO Ingredients (iid, name, price)
VALUES (247, 'shallot', 2.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (248, 'sardine', 1.44);

INSERT INTO Ingredients (iid, name, price)
VALUES (249, 'seaweed', 3.78);

INSERT INTO Ingredients (iid, name, price)
VALUES (250, 'strawberries', 3.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (251, 'mascarpone', 9.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (252, 'condensed milk', 2.67);

INSERT INTO Ingredients (iid, name, price)
VALUES (253, 'cones', 3.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (254, 'sprinkles', 2.59);

INSERT INTO Ingredients (iid, name, price)
VALUES (255, 'water', 1.05 );

INSERT INTO Ingredients (iid, name, price)
VALUES (256, 'tofu', 1.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (257, 'dark chocolate', 5.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (258, 'soured cream', 3.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (259, 'red chili', 2.98);

INSERT INTO Ingredients (iid, name, price)
VALUES (260, 'cannellini beans', 0.88);

INSERT INTO Ingredients (iid, name, price)
VALUES (261, 'butter beans', 2.28);

INSERT INTO Ingredients (iid, name, price)
VALUES (262, 'vinegar', 1.48);

INSERT INTO Ingredients (iid, name, price)
VALUES (263, 'parsley', 1.47);


INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (101, 'Pasta', 301,
ARRAY ['Bring a saucepan of salted water to the boil and cook linguine according to the packet instructions.',
'Meanwhile, drizzle a lug of oil into a medium saucepan over a medium heat, add the tomato passata and capers (rinsed), then finely grate in half the lemon zest.  Simmer for 5 to 7 minutes, then season to taste.',
'When the linguine is al dente, drain and toss with the sauce to coat. To serve, finely grate over some Parmesan and extra lemon zest, if desired.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (102, 'Omelet',300,
ARRAY['Beat egg and egg whites in a small bowl. Mix in Parmesan cheese, Cheddar cheese, salt, red pepper flakes, garlic powder, nutmeg, and pepper.',
'Heat oil in a large skillet over medium heat; cook and stir mushrooms, green onion, and bell pepper until tender, about 5 minutes.', 'Place spinach in skillet and cook until just wilted. Stir in diced tomato and egg mixture; as eggs set, lift edges, letting uncooked portion flow underneath.',
'Cook until egg mixture sets, 10 to 15 minutes; cut into wedges and serve immediately.'
]);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (105, 'Egg Salad Sandwich' ,300,
ARRAY['Place egg in a saucepan and cover with cold water.','Bring water to a boil and immediately remove from heat.','Cover and let eggs stand in hot water for 10 to 12 minutes.','Remove from hot water, cool, peel and chop.','Place the chopped eggs in a bowl, and stir in the mayonnaise, mustard and green onion.','Season with salt, pepper and paprika.','Stir and serve on your favorite bread or crackers.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (106, 'Broiled Scallops', 300,
ARRAY ['Turn broiler on.', 'Rinse scallop and place in a shallow baking pan. Sprinkle with garlic sal and melted butter to margarine and lemon juice.',
'Broil 6 to 8 minutes or until scallops start to turn golden. Remove from oven and serve with extra melted butter or margarine on the side for dipping.']);



INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (108, 'Hamburger Steak' ,300,
ARRAY['In a large bowl, mix together the ground beef, egg, bread crumbs, pepper, salt, onion powder, garlic powder, and Worcestershire sauce.',
'Form into 8 balls, and flatten into patties.',
'Heat the oil in a large skillet over medium heat.',
'Fry the patties and onion in the oil until patties are nicely browned, about 4 minutes per side.',
'Remove the beef patties to a plate, and keep warm.',
'Sprinkle flour over the onions and drippings in the skillet.',
'Stir in flour with a fork, scraping bits of beef off of the bottom as you stir.',
'Gradually mix in the beef broth and sherry.',
'Season with seasoned salt.',
'Simmer and stir over medium-low heat for about 5 minutes, until the gravy thickens.',
'Turn heat to low, return patties to the gravy, cover, and simmer for another 15 minutes.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (109, 'Eggplant Parmesan', 300,
ARRAY ['In a small bowl beat the egg and water together. Place the bread crumbs in shallow dish. Dip eggplant slices in egg mixture then in crumbs, being sure to coat thoroughly.',
'Heat oil in a large skillet over medium-high heat until hot. Add eggplant slices and reduce heat to medium. Cook for 3 to 4 minutes per side or until golden brown and tender. Sprinkle mozzarella cheese over eggplant during last minute of cooking to melt.',
'While eggplant is cooking, combine spaghetti sauce and pepper flakes in a microwave-safe measuring cup. Cover with plastic wrap and cook at high power for 2 minutes or until heated through.',
'Top eggplant with sauce and Parmesan cheese and serve.']);


INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (111, 'Beef Stir-Fry' ,302,
ARRAY['Heat vegetable oil in a large wok or skillet over medium-high heat; cook and stir beef until browned, 3 to 4 minutes.',
'Move beef to the side of the wok and add broccoli, bell pepper, carrots, green onion, and garlic to the center of the wok.',
'Cook and stir vegetables for 2 minutes. Stir beef into vegetables and season with soy sauce and sesame seeds.',
'Continue to cook and stir until vegetables are tender, about 2 more minutes.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (112, 'One-pan Taco', 303,
ARRAY ['Spray large nonstick skillet with nonstick cooking spray. Add meat and brown over medium-high heat; drain off excess fat.',
'Add seasoning mix and water; stir. Bring to boil.',
'Stir in rice. Sprinkle with cheese; cover. Reduce heat to low; simmer 5 minutes. Top with lettuce and tomato just before serving.']);


INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (114, 'Garlic Chicken' ,300,
ARRAY['Melt butter in a large skillet over medium high heat.',
'Add chicken and sprinkle with garlic powder, seasoning salt and onion powder.',
'Saute about 10 to 15 minutes on each side, or until chicken is cooked through and juices run clear.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (116, 'Chicken Stirfry' ,302,
ARRAY['Heat vegetable oil in a large wok or skillet over medium-high heat; cook and stir chicken until browned, 6 to 8 minutes.',
'Move chicken to the side of the wok and add broccoli, bell pepper, carrots, green onion, and garlic to the center of the wok.',
'Cook and stir vegetables for 2 minutes. Stir chicken into vegetables and season with soy sauce and sesame seeds.',
'Continue to cook and stir until vegetables are tender, about 2 more minutes.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (118, 'Roasted Chicken and Vegetables in a Pan' ,300,
ARRAY['Preheat oven to 500 degree F. Chop all the veggies into large pieces.',
'In another cutting board chop the chicken into cubes.',
'Place the chicken and veggies in a medium roasting dish or sheet pan.',
'Add the olive oil, salt and pepper, italian seasoning, and paprika. Toss to combine.',
'Bake for 15 minutes or until the veggies are charred and chicken is cooked.',
'Enjoy with rice, pasta, or a salad.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (119, 'Sardine Curry', 304,
ARRAY ['Heat the canola oil in a skillet.',
'Stir the red curry paste into the hot oil; cook and stir for a few seconds before adding the garlic and shallot.',
 'Cook and stir the garlic and shallot until fragrant. Add the sardines; toss around in the pan to brown the skin a little bit and cover it well with the paste mixture.',
 'Gently stir the coconut cream into the mixture and continue to toss to coat the sardines. Allow mixture to come to a boil until the sauce thickens, about 5 minutes.']);


INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (120, 'Chicken Vegetable Stew',300,
ARRAY['In a large pot, put the chopped onion, chicken breast meat, carrots and potatoes.',
'Add the salt and turmeric. Dissolve the tomato paste in water and add.',
'If desired, add garlic powder and ground black pepper to season.',
'Cook for 1 to 1 1/2 hours on medium low heat. Serve.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (122, 'Strawberry Ice Cream', 300,
ARRAY ['Pull the green hulls out of the strawberries. If they are still quite hard, cut them in half or quarters with a table knife.',
'Tip them into a flat-bottomed dish.',
'Use a potato masher to squash the strawberries as much as you can. Tip into a bowl. Ask your grown-up helper to give you a hand if you need to.',
'Add the mascarpone and mash this in – don`t worry if it is a bit lumpy. Add the condensed milk and mix everything together. Don`t worry if the mix is streaky.',
'Spoon the mixture into a metal or plastic box and put it in the freezer. Wait until the next day or at least 6 hours before scooping into bowls or cones. Decorate how you like.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (123, 'Chocolate Cup Cake', 300,
ARRAY ['Heat oven to 180C/fan 160C/gas 4 and line a 10-hole muffin tin with paper cases. Whizz the chocolate into small pieces in a food processor. In the largest mixing bowl you have, tip in the flour, sugar, cocoa, oil, 100ml soured cream, eggs, vanilla and 100ml water. Whisk everything together with electric beaters until smooth, then quickly stir in 100g of the whizzed-up chocolate bits. Divide between the 10 cases, then bake for 20 mins until a skewer inserted comes out clean (make sure you don’t poke it into a chocolate chip bit). Cool on a wire rack.',
'To make the icing, put the remaining chocolate bits, soured cream and 3 tbsp sugar in a small saucepan. Heat gently, stirring, until the chocolate is melted and you have a smooth icing. Chill in the fridge until firm enough to swirl on top of the muffins, then tuck in.']);


INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (124, 'Chicken & Vegetable Pasta',301,
ARRAY['Cook linguine pasta according to package directions. Drain. Set aside; keep warm.',
'Melt butter in 12-inch skillet until sizzling; add chicken, garlic and thyme.',
'Cook over medium-high heat, stirring occasionally, 5-8 minutes or until chicken is no longer pink.'
'Stir in vegetables.',
'Continue cooking, stirring occasionally, 6-9 minutes or until vegetables are crisply tender',
'Stir in cooked fusilli and cheese.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (126, 'Italian Bean Salad', 301,
ARRAY ['Finely chop the spring onions and put into a bowl with the garlic and the chilli.',
'Mix in the cannellini beans and the butter beans.',
'Whisk the olive oil with the white wine vinegar and add plenty of seasoning.',
'Stir through the salad with plenty of chopped parsley.']);


INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (100, 'Chicken Fried Rice',302,
ARRAY['In a small bowl, beat egg with water.',
'Melt butter in a large skillet over medium low heat.',
'Add egg and leave flat for 1 to 2 minutes. Remove from skillet and cut into shreds.',
'Heat oil in same skillet; add onion and saute until soft.',
'Then add rice, soy sauce, pepper and chicken.',
'Stir fry together for about 5 minutes, then stir in egg. Serve hot.']);


INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (103, 'Baked French Fries', 300, ARRAY['Preheat oven to 450 degrees F (230 degrees C).', 'Cut potato into wedges.','Mix olive oil, paprika, garlic powder, chili powder and onion powder together.','Coat potatoes with oil/spice mixture and place on a baking sheet.','Bake for 45 minutes in preheated oven.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (104, 'French Toast', 300, ARRAY['Measure flour into a large mixing bowl.','Slowly whisk in the milk. Whisk in the salt, eggs, cinnamon, vanilla extract and sugar until smooth.','Heat a lightly oiled griddle or frying pan over medium heat.','Soak bread slices in mixture until saturated.','Cook bread on each side until golden brown. Serve hot.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (107, 'Baked Kale Chips', 300, ARRAY['Preheat an oven to 350 degrees F (175 degrees C).','Line a non insulated cookie sheet with parchment paper.','With a knife or kitchen shears carefully remove the leaves from the thick stems and tear into bite size pieces.','Wash and thoroughly dry kale with a salad spinner.','Drizzle kale with olive oil and sprinkle with seasoning salt.','Bake until the edges brown but are not burnt, 10 to 15 minutes.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (110, 'Fried Chicken', 300, ARRAY['Place crackers in a large resealable plastic bag; seal bag and crush crackers with a rolling pin until they are coarse crumbs.','Add the flour, potato flakes, seasoned salt, and pepper and mix well. Beat egg in a shallow dish or bowl.','One by one, dredge chicken pieces in egg, then place in bag with crumb mixture. Seal bag and shake to coat.','Heat oil in a deep-fryer or large saucepan to 350 degrees F (175 degrees C).','Fry chicken, turning frequently, until golden brown and juices run clear, 15 to 20 minutes.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (113, 'Pan Fried Asparagus', 300, ARRAY['Melt butter in a skillet over medium-high heat.','Stir in the olive oil, salt, and pepper.','Cook garlic in butter for a minute, but do not brown.','Add asparagus, and cook for 10 minutes, turning asparagus to ensure even cooking.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (115, 'Grilled Cheese', 300, ARRAY['Preheat skillet over medium heat.','Generously butter one side of a slice of bread.','Place bread butter-side-down onto skillet bottom and add 1 slice of cheese.','Butter a second slice of bread on one side and place butter-side-up on top of sandwich.','Grill until lightly browned and flip over; continue grilling until cheese is melted.','Repeat with remaining 2 slices of bread, butter and slice of cheese.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (117, 'Fresh Spring Rolls', 305, ARRAY['1. Fill a small saucepan with some water and add a little salt. Bring to a boil. Add the prawns and boil until they bright pink, about 2-3 mins. Be careful not to overcook them.','2. In a separate saucepan, boil the green beans for 2-4 mins. until blanched and set aside.','3. Prepare the rice paper following the instruction on the package. Normally this involves soaking the rice paper wrappers in cool water for a few seconds until pliable.','4. Lay the rice paper on clean cloth. Arrange the mint/coriander leaves on the bottom of the rice paper and add the prawn halves in the middle.','5. Top with the green beans and one whole chive/spring onion. Sprinkle a little salt on top to taste.','6. Fold the sides in and tightly roll to ensure all ingredients are inside.','7. Make the dipping sauce by mixing all the ingredients together.','8. Serve spring rolls with the dipping sauce as a snack or side.']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (121, 'Miso Soup', 305, ARRAY['1.Start by preparing your ingredients. Rehydrate the seaweed with water in a bowl, chop up the tofu into small 1cm cubes.','2.Boil about 1L of water.','3.In the meantime, pour a small amount of the water into a smaller pan and stir in 2 tablespoons of miso paste (this is to avoid making a lumpy soup).','4.Remove the rehydrated wakame from the water, add the wakame seaweed and tofu directly to the stock.','5.Add the dissolved miso paste to the stock and stir to keep the mixture smooth, turn off the heat. Do not allow the soup to boil, this helps retain the miso flavour.','6.Serve into small bowls and add the sliced spring onion to the bowls']);

INSERT INTO Recipes (rid, name, cid, instructions)
VALUES (125, 'Tofu Shake', 305, ARRAY['Put all ingredients into a blender.','Blend until smooth and enjoy.']);


INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(201,101, '2 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(203,101, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(210,101, '3');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(211,101, 'half');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(212,101, '1/4 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(207,101, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208,101, '2 tsp');

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
VALUES(222,106, '12');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(207,106, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(221,106, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(211,106, 'half');

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
VALUES(200,109, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(228,109, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(227,109, '1/4 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(201,109, '2 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(230,109, '2 tsp');


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
VALUES(224,112, '1lb');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208,112, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(236,112, '1 pkg');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(237,112, '2 cups');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(203,112, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(238,112, '2 cups');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(201,112, '1 cup');


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
VALUES(208,119, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(246,119, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(247,119, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(248,119, '1 can');


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
VALUES(250,122, '400g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(251,122, '250g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(252,122, '397g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(253,122, 'any');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(254,122, 'any');

INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(215,123, '200g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(257,123, '300g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(213,123, '3 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208,123, '150ml ');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(258,123, '284g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(254,123, '284g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(200,123, '2');


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
VALUES(205,126, '1 bunch');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(233,126, '2 cloves');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(259,126, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(260,126, '1 can');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(261,126, '1 can');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(208,126, '6 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(262,126, '2 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement)
VALUES(263,126, 'many');


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

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (206, 103, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (208, 103, '1 tbl');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (207, 103, 'to taste');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (209, 103, 'to taste');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (215, 104, '1/4 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (216, 104, '1 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (207, 104, '1 pinch');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (200, 104, '3');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (214, 104, '1/2 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (217, 104, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (213, 104, '1 tbl');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (220, 104, '12 slices');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (223, 107, '1 bunch');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (207, 107, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (208, 107, '1 tbl');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (226, 110, '30');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (215, 110, '2 tbl');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (227, 110, '2 tbl');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (207, 110, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (209, 110, '1/2 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (200, 110, '1');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (229, 110, '6 boneless breast');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (208, 110, '2 cups');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (221, 113, '1/4 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (208, 113, '2 tbl');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (207, 113, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (209, 113, '1/4 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (233, 113, '3 cloves');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (230, 113, '1 pound');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (220, 115, '4 slices');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (201, 115, '2 slices');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (221, 115, '3 tbl');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (239, 117, '2-3');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (240, 117, 'a bunch');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (241, 117, '2');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (207, 117, 'a pinch of');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (242, 117, '2-3');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (243, 117, '2-3');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (244, 117, '10 g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (218, 117, '10 g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (245, 117, '3 g');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (244, 121, '2 tbsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (256, 121, '1 pack');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (255, 121, '1 L');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (249, 121, '1 sheet');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (243, 121, '1 stalk');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (256, 125, '350 g');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (216, 125, 'soy, 1/2 cup');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (213, 125, '1 tsp');

INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (217, 125, '1 tsp');
INSERT INTO Ingredients_Recipes (iid, rid, measurement) VALUES (255, 125, 'ice cubes, a handful');
