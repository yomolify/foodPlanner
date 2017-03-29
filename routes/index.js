var express = require('express');
var router = express.Router();

var db = require('../queries');

// Create Read Update Delete (CRUD)

// Recipes
router.get('/api/recipes', db.getAllRecipes);
router.get('/api/recipes/:id', db.getSingleRecipe);
router.post('/api/recipes/name', db.getRecipesByName);
router.post('/api/recipes', db.createRecipe);
router.put('/api/recipes/:id', db.updateRecipe);
router.delete('/api/recipes/:id', db.removeRecipe);

// Ingredients
router.get('/api/ingredients', db.getAllIngredients);

// Users
router.post('/api/users', db.createUser);
router.post('/api/login', db.loginUser);

// Meals
router.post('/api/meal/recipes', db.getMealRecipes);

// router.get('/api/ingredients', db.getAllIngredients);

module.exports = router;