var promise = require('bluebird');

var options = {
    // Initialization Options
    promiseLib: promise
};

var pgp = require('pg-promise')(options);
var connectionString = 'postgres://localhost:5432/foodplanner';
var db = pgp(connectionString);

// Recipe Queries

// select distinct ir.rid from ingredients_recipes ir where ir.rid in ((select ir1.rid from ingredients_recipes ir1 where ir1.iid=229) intersect (select ir2.rid from ingredients_recipes ir2 where ir2.iid=234));

function getAllRecipes(req, res, next) {
    db.any('select * from recipes')
        .then(function (data) {
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved all recipes'
                });

        })
        .catch(function (err) {
            return next(err);
        });
}

function getSingleRecipe(req, res, next) {
    var rid = parseInt(req.params.id);
    db.one('select * from recipes where rid = $1', rid)
        .then(function (data) {
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved one recipe'
                });
        })
        .catch(function (err) {
            return next(err);
        });
}

function getRecipesByName(req, res, next) {
    db.many("select name, rid from recipes where name like '%$1#%'", req.body.name)
        .then(function (data) {
            console.log(data)
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved recipes by name'
                });
        })
        .catch(function (err) {
            console.log("ERROR:", err.message || err); // print error;
            return next(err);
        });
}

function getRecipesByIngredients(req, res, next){
    console.log(req.body);
    db.many("select distinct on (r.name) r.name, ir.rid from ingredients_recipes ir, recipes r " +
        "where ir.rid = r.rid and ir.rid in (" +
        "(select ir1.rid from ingredients_recipes ir1 where ir1.iid=$1) intersect " +
        "(select ir2.rid from ingredients_recipes ir2 where ir2.iid=$2) intersect" +
        "(select ir3.rid from ingredients_recipes ir3 where ir3.iid=$3))",
    [req.body.one, req.body.two, req.body.three])
        .then(function(data){
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved all recipes'
                });
        })
        .catch(function(err){
            console.log("ERROR:", err.message || err);
            return next(err);
        })
}

function createRecipe(req, res, next) {
    db.none('insert into recipes(name, cid, instructions)' +
        'values(${name}, ${cid}, ${instructions})',
        req.body)
        .then(function () {
            res.status(200)
                .json({
                    status: 'success',
                    message: 'Inserted one recipe'
                });
        })
        .catch(function (err) {
            return next(err);
        });
}

function updateRecipe(req, res, next) {
    db.none('update recipes set name=$1, cid=$2, instructions=$3 where id=$4',
        [req.body.name, req.body.cid, req.body.instructions, parseInt(req.params.id)])
        .then(function () {
            res.status(200)
                .json({
                    status: 'success',
                    message: 'Updated recipe'
                });
        })
        .catch(function (err) {
            return next(err);
        });
}

function removeRecipe(req, res, next) {
    var rid = parseInt(req.params.id);
    db.result('delete from recipes where rid = $1', rid)
        .then(function (result) {
            res.status(200)
                .json({
                    status: 'success',
                    message: 'Removed ${result.rowCount} recipe'
                });
        })
        .catch(function (err) {
            return next(err);
        });
}

// Ingredient Queries
function getAllIngreidents(req, res, next) {
    db.any('select * from ingredients')
        .then(function (data) {
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved all recipes'
                });
        })
        .catch(function (err) {
            return next(err);
        });
}

// User Queries

function createUser(req, res, next) {
    console.log(req.body);
    // res.status(200).send('hi');


    db.many("insert into users(name, utid) values($1, $2) returning uid, name", [req.body.name, req.body.utid])
        .then(function (data) {
            res.status(200)
                .json({
                    status: 'success',
                    message: 'Inserted one user',
                    data: data
                });

        })
        .catch(function (error) {
            console.log("ERROR:", error.message || error); // print error;
            return next(error);
        })
}

function loginUser(req, res, next) {
    console.log(req.body)
    db.many('select * from users where name = ${name}', req.body)
        .then(function (data) {
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Logged in user'
                });
        })
        .catch(function (err) {
            return next(err);
        });
}

// mealPlan queries

function getMealRecipes(req, res, next) {

    db.many("select r.name, r.rid from recipes r where r.rid in " +
        "(select mr.rid from mealplan_recipe mr where mr.mid=" +
        "(select mu.mid from mealplan_user mu where name=$1 and uid=$2))", [req.body.name, req.body.uid])
        .then(function (data) {
            console.log(JSON.stringify(data))
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved recipes by meal plan'
                });
        })
        .catch(function (err) {
            console.log("ERROR:", err.message || err); // print error;
            return next(err);
        });
}

function getMealPlanID(req, res, next){
    db.one('select distinct mr.mid from mealplan_recipe mr, mealplan_user mu' +
        'mr.mid = mu.mid and mu.uid = $1 and mu.name = $2', [req.body.uid, req.body.name])
        .then(function (data){
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Retrieved mealplan ID for user'
                });
        })
        .catch(function (err){
            return next(err);
        })
}

function addMealPlanRecipe(req, res, next){
    db.one('insert into mealplan_recipe(mid, rid) values($1, $2)', [req.body.mid, req.body.rid])
        .then(function (data){
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message: 'Inserted new recipe into MealPlan'
                });
        })
        .catch(function (err){
            return next(err);
        })
}

// ingredients_recipes queries
function getIngredientsRecipes(req, res, next){
    db.many('select * from ingredients_recipes ir, ingredients i' +
        ' where ir.iid = i.iid and ir.rid = $1', req.body.rid)
        .then(function(data){
            res.status(200)
                .json({
                    status: 'success',
                    data: data,
                    message:'Retrieved ingredients for recipe'
                })
        })
        .catch(function(err){
            return next(err);
        })

}


module.exports = {
    getAllRecipes: getAllRecipes,
    getSingleRecipe: getSingleRecipe,
    createRecipe: createRecipe,
    updateRecipe: updateRecipe,
    removeRecipe: removeRecipe,
    createUser: createUser,
    loginUser: loginUser,
    getRecipesByName: getRecipesByName,
    getAllIngredients: getAllIngreidents,
    getMealRecipes: getMealRecipes,
    getIngredientsRecipes : getIngredientsRecipes,
    getRecipesByIngredients : getRecipesByIngredients,
    getMealPlanID : getMealPlanID,
    addMealPlanRecipe : addMealPlanRecipe
};
