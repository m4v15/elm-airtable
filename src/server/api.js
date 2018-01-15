const path = require("path");
const express = require("express");
const bodyParser = require("body-parser");
const router_api = require("./routers/api");

const app = express();

app.use(express.static(path.join(__dirname, "../../dist/")));
app.use(bodyParser.json());

app.use(router_api);

module.exports = app;
