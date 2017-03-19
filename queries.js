var promise = require('bluebird');

var options = {
  // Initialization Options
  promiseLib: promise
};

var pgp = require('pg-promise')(options);
var connectionString = 'postgres://localhost:5432/foodPlanner';
var db = pgp(connectionString);

// Recipe Queries

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
          message: `Removed ${result.rowCount} recipe`
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

// User Queries

function createUser(req, res, next) {
  console.log(req.body)

  db.one("insert into users(name) values($1) returning uid, name", [req.body.name])
    .then(data => {
        res.status(200)
        .json({
          status: 'success',
          message: 'Inserted one user',
          data: data
        });
    })
    .catch(error => {
        console.log("ERROR:", error.message || error); // print error;
    })
}

function loginUser(req, res, next) {
  db.one('select * from users where name = ${name}', req.body)
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

module.exports = {
  getAllRecipes: getAllRecipes,
  getSingleRecipe: getSingleRecipe,
  createRecipe: createRecipe,
  updateRecipe: updateRecipe,
  removeRecipe: removeRecipe,
  createUser: createUser,
  loginUser: loginUser
};
