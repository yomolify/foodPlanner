var app = angular.module('planner', []);

app.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider
            .when("/welcome", {
                templateUrl : "welcome.html"
            })
            .when("/home", {
                templateUrl : "../views/home.html"
            })
            .when("/searchIngredient", {
                templateUrl : "../views/blue.htm"
            })
            .otherwise({
                redirectTo: "/welcome"
            });
}]);

app.service('recipeService', function(){
    var recipeList = [];

    var addRecipes = function(newObj){
        recipeList = recipeList.concat(newObj);
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

app.service('userService', function(){
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
})

app.controller('WelcomePageController', function($scope, $http, $location, userService){
    $scope.welcomeShow = true;
    $scope.homeShow = false;
    $scope.nameShow = false;
    $scope.resultShow = false;
    $scope.display = 'hi';

    $scope.username = '';

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
                userService.setUser(resp.data.name, resp.data.uid);
                // $scope.username = resp.data.name;
                // $scope.display = resp.data.name;
                $location.path('/home')
            })
    }

    $scope.login = function(){
        var data = {"name" : $scope.username};
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
                userService.setUser(resp.data.name, resp.data.uid);
                // $scope.display = resp.data.name;
                $scope.welcomeShow = false;
                $scope.homeShow = true;
            })
    }
})

app.controller('SearchByName', function($scope, $http, $location, recipeService){
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
                var rec = resp.data;
                recipeService.addRecipes(rec);
                $location.path('/recipeResults');
            })
    }
})

app.controller('SearchByName', function($scope, $http, $location, recipeService){
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
                var rec = resp.data;
                recipeService.addRecipes(rec);
                $location.path('/recipeResults');
            })
    }
})


