var app = angular.module('planner', ['ngRoute']);

app.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.
        when('/welcome', {
            templateUrl: 'views/welcome.html',
            controller: 'WelcomeController'
        }).
        when('/home', {
            templateUrl: 'views/home.html',
            controller: 'HomeController'
        }).
        when('/searchName', {
            templateUrl: 'views/searchName.html',
            controller: 'SearchNameController'
        }).
        when('/recipeResults', {
            templateUrl: 'views/recipeResults.html',
            controller: 'RecipeResultsController'
        }).
        when('/recipe/:rid', {
            templateUrl: 'views/recipe.html',
            controller: 'RecipeController'
        }).
        when('/mealplan', {
            templateUrl: 'views/mealplan.html',
            controller: 'SearchBreakfastRecipesController',
            controller: 'SearchLunchRecipesController',
            controller: 'SearchDinnerRecipesController',
            controller: 'SearchSnacksRecipesController'
        }).
        when('/breakfast', {
            templateUrl: 'views/breakfast.html',
            controller: 'BreakfastRecipeResultsController'
        }).
        when('/lunch', {
            templateUrl: 'views/lunch.html',
            controller: 'LunchRecipeResultsController'
        }).
        when('/dinner', {
            templateUrl: 'views/dinner.html',
            controller: 'DinnerRecipeResultsController'
        }).
        when('/snacks', {
            templateUrl: 'views/snacks.html',
            controller: 'SnacksRecipeResultsController'
        }).
        when('/searchIngredients', {
            templateUrl: 'views/searchIngredients.html',
            controller: 'SearchIngredientsController'
        }).
        otherwise({
            redirectTo: '/welcome'
        });
    }]);

app.factory('recipeService', function(){
    var recipeList = [];

    var addRecipes = function(newObj){
        recipeList = newObj;
    };

    var deleteAllRecipes = function(){
        recipeList = [];
    };

    var retrieveRecipes = function(){
        return recipeList;
    };

    return {
        addRecipes : addRecipes,
        deleteAllRecipes : deleteAllRecipes,
        retrieveRecipes : retrieveRecipes
    }
});

app.factory('userService', function(){
    var userInfo = {username: '', user_id : -1};

    var setUser = function(username, id){
        userInfo.username = username;
        userInfo.user_id = id;
    }

    var retrieveUser = function(){
        return userInfo;
    }

    var removeUserInfo = function(){
        userInfo.username = '';
        userInfo.user_id = -1
    }

    return {
        setUser : setUser,
        retrieveUser : retrieveUser,
        removeUserInfo : removeUserInfo
    }
});

app.controller('WelcomeController', function($scope, $http, $location, userService){
    $scope.welcomeShow = true;
    $scope.homeShow = false;
    $scope.nameShow = false;
    $scope.resultShow = false;
    $scope.display = 'hi';

    $scope.username = '';
    $scope.loginname = '';

    $scope.signUp = function(){
        var data = {"name" : $scope.username, "utid" : 1};
        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/users',
            headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                $scope.display = resp.data;
                userService.setUser(resp.data.data[0].name, resp.data.data[0].uid);
                $scope.display = userService.retrieveUser();
                $location.path('/home');
                // $scope.username = resp.data.name;
                // $scope.display = resp.data.name;

            })
    };

    $scope.login = function(){
        var data = {"name" : $scope.loginname};
        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/login',
            headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                userService.setUser(resp.data.data[0].name, resp.data.data[0].uid);
                $location.path('/home');
            })
    }
});

app.controller('HomeController', function($scope, userService){
    $scope.username = 'hi';
    $scope.getName = function(){
        $scope.username = userService.retrieveUser().username;
    }
});

app.controller('SearchNameController', function($scope, $http, $location, recipeService){
    $scope.display = 'hi';
    $scope.recipeName = '';
    $scope.searchRecipe = function(){
        var data = {"name" : $scope.recipeName};

        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/recipes/name',
            headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                var rec = resp.data.data;
                recipeService.addRecipes(rec);
                $scope.display = recipeService.retrieveRecipes();
                $location.path('/recipeResults');
            })
    }
});

app.controller('RecipeResultsController', function($scope, recipeService){
    $scope.recipes = [];
    $scope.display = 'hi';
    $scope.getResults = function() {
        $scope.display = recipeService.retrieveRecipes();
        $scope.recipes = recipeService.retrieveRecipes();
    }
});

app.controller('BreakfastRecipeResultsController', function($scope, recipeService){
    $scope.recipes = [];
    $scope.display = 'Breakfast';
    $scope.getResults = function() {
        $scope.display = recipeService.retrieveRecipes();
        $scope.recipes = recipeService.retrieveRecipes();
    }
});

app.controller('LunchRecipeResultsController', function($scope, recipeService){
    $scope.recipes = [];
    $scope.display = 'Lunch';
    $scope.getResults = function() {
        $scope.display = recipeService.retrieveRecipes();
        $scope.recipes = recipeService.retrieveRecipes();
    }
});

app.controller('DinnerRecipeResultsController', function($scope, recipeService){
    $scope.recipes = [];
    $scope.display = 'Dinner';
    $scope.getResults = function() {
        $scope.display = recipeService.retrieveRecipes();
        $scope.recipes = recipeService.retrieveRecipes();
    }
});

app.controller('SnacksRecipeResultsController', function($scope, recipeService){
    $scope.recipes = [];
    $scope.display = 'Snacks';
    $scope.getResults = function() {
        $scope.display = recipeService.retrieveRecipes();
        $scope.recipes = recipeService.retrieveRecipes();
    }
});

app.controller('RecipeController', function($scope, $routeParams, $http, userService){
    $scope.display = 'hi';
    $scope.recipe_id = $routeParams.rid;
    $scope.recipeName = 'RecipeName';
    $scope.mealPlan = 'Breakfast';
    $scope.rid = -1;

    $scope.getDetails = function(){
        var req = {
            method: 'GET',
            url: 'http://localhost:3000/api/recipes/' + $scope.recipe_id,
            headers: {
                'Content-Type': 'application/json'
            }
        };

        $http(req)
            .then(function(resp){
                var data = resp.data.data;
                $scope.recipeName = data.name;
                $scope.instructions = data.instructions;
                $scope.rid = data.rid
                var reqdata = {rid : data.rid};
                var req2 = {
                    method: 'POST',
                    url: 'http://localhost:3000/api/ingredientsRecipes/',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    data : reqdata
                };
                return $http(req2)
                    .then(function(resp){
                        $scope.display = $scope.instructions;
                        $scope.recipeIngredients = resp.data.data;
                    })
            })
    }
    $scope.addToMealPlan = function(){
        var uid = userService.retrieveUser().user_id;
        var data = {"uid" : uid, "name": $scope.mealPlan};
        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/mealplanid',
            headers: {
                'Content-Type': 'application/json'
            },
            data : data
        }
        $http(req)
            .then(function(resp){
                var data = resp.data.data;
                var reqdata = {rid : $scope.rid, mid : data.mid};
                var req2 = {
                    method: 'POST',
                    url: 'http://localhost:3000/api/mealplans/',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    data : reqdata
                };
                return $http(req2)
                    .then(function(resp){
                        $scope.display = 'added to mealplan';
                    })
            })
    }
});

app.controller('SearchIngredientsController', function($scope, $http, $location, recipeService){
    $scope.display = 'hi';
    $scope.recipeName = '';
    $scope.ingredientOne = {};
    $scope.ingredientTwo = {};
    $scope.ingredientThree = {};
    $scope.getIngredients = function(){
        var req = {
            method: 'GET',
            url: 'http://localhost:3000/api/ingredients',
            headers: {
                'Content-Type': 'application/json'
            }
        };

        $http(req)
            .then(function(resp){
                $scope.ingredients = resp.data.data;
            })
    }
    $scope.searchRecipe = function(){
        var data = {"one" : $scope.ingredientOne.iid,
            "two" : $scope.ingredientTwo.iid,
            "three" : $scope.ingredientOne.iid};

        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/getRecipesIngredients',
            headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                var rec = resp.data.data;
                recipeService.addRecipes(rec);
                $location.path('/recipeResults');
            })
    }
});

app.controller('SearchBreakfastRecipesController', function($scope, $http, $location, userService, recipeService){
    $scope.mealName = '';
    var curr_user = userService.retrieveUser();
    var curr_user_id = curr_user.user_id;
    $scope.display = curr_user_id;
    $scope.searchMealRecipe = function(){
        var data = {"name" : "Breakfast", "uid": curr_user_id};

        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/meal/recipes', headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                var rec = resp.data.data;
                recipeService.addRecipes(rec);
                $scope.display = recipeService.retrieveRecipes();
                $location.path('/breakfast');
            })
    }
});

app.controller('SearchLunchRecipesController', function($scope, $http, $location, userService, recipeService){
    $scope.mealName = '';
    var curr_user = userService.retrieveUser();
    var curr_user_id = curr_user.user_id;
    $scope.display = curr_user_id;
    $scope.searchMealRecipe = function(){
        var data = {"name" : "Lunch", "uid": curr_user_id};

        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/meal/recipes',
            headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                var rec = resp.data.data;
                recipeService.addRecipes(rec);
                $scope.display = recipeService.retrieveRecipes();
                $location.path('/lunch');
            })
    }
});

app.controller('SearchDinnerRecipesController', function($scope, $http, $location, userService, recipeService){
    $scope.mealName = '';
    var curr_user = userService.retrieveUser();
    var curr_user_id = curr_user.user_id;
    $scope.display = curr_user_id;
    $scope.searchMealRecipe = function(){
        var data = {"name" : "Dinner", "uid": curr_user_id};

        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/meal/recipes',
            headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                var rec = resp.data.data;
                recipeService.addRecipes(rec);
                $scope.display = recipeService.retrieveRecipes();
                $location.path('/dinner');
            })
    }
});

app.controller('SearchSnacksRecipesController', function($scope, $http, $location, userService, recipeService){
    $scope.mealName = '';
    var curr_user = userService.retrieveUser();
    var curr_user_id = curr_user.user_id;
    $scope.display = curr_user_id;
    $scope.searchMealRecipe = function(){
        var data = {"name" : "Snacks", "uid": curr_user_id};

        var req = {
            method: 'POST',
            url: 'http://localhost:3000/api/meal/recipes',
            headers: {
                'Content-Type': 'application/json'
            },
            data: data
        };

        $http(req)
            .then(function(resp){
                var rec = resp.data.data;
                recipeService.addRecipes(rec);
                $scope.display = recipeService.retrieveRecipes();
                $location.path('/snacks');
            })
    }
});

// app.controller('RecipeController', function($scope, $routeParams){
//     $scope.recipe_id = $routeParams.rid;
//     $scope.getDetails = function(){
//         var req = {
//             method: 'POST',
//             url: 'http://localhost:3000/api/recipes/' + $scope.recipe_id,
//             headers: {
//                 'Content-Type': 'application/json'
//             },
//             data: data
//         };

//         $http(req)
//             .then(function(resp){
//                 var data =
//                 // userService.setUser(resp.data.name, resp.data.uid);
//                 // $scope.display = resp.data.name;
//                 $scope.welcomeShow = false;
//                 $scope.homeShow = true;
//             })
//     }

// }
//
// app.controller('SearchByIngredients', function($scope, $http, $location, recipeService){
//     $scope.recipeName = '';
//     $scope.searchRecipe = function(){
//         var data = {"name" : $scope.recipeName};
//
//         var req = {
//             method: 'POST',
//             url: 'http://localhost:3000/api/recipes/name',
//             headers: {
//                 'Content-Type': 'application/json'
//             },
//             data: data
//         };
//
//         $http(req)
//             .then(function(resp){
//                 var rec = resp.data;
//                 recipeService.addRecipes(rec);
//                 $location.path('/recipeResults');
//             })
//     }
// })
//
//
