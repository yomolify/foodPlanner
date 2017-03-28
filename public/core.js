var app = angular.module('planner', []);

app.controller('foodPlannerController', function($scope, $http){
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
                // $scope.username = resp.data.name;
                // $scope.display = resp.data.name;
                $scope.welcomeShow = false;
                $scope.homeShow = true;
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
                $scope.username = resp.data.name;
                // $scope.display = resp.data.name;
                $scope.welcomeShow = false;
                $scope.homeShow = true;
            })
    }
})