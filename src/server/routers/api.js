const router = require("express").Router();
require("dotenv").config();
const Airtable = require("airtable");
const base = Airtable.base("appzd6TukaurHCpiE");
Airtable.configure({
  endpointUrl: "https://api.airtable.com",
  apiKey: process.env.AIRTABLE_API_KEY
});

router
  .route("/players")
  .get((req, res, next) => {
    let allRecords = [];
    base("Info")
      .select({
        view: "Grid view"
      })
      .eachPage(
        (records, fetchNextPage) => {
          // This function will get called for each page of records.

          allRecords = allRecords.concat(records);

          // To fetch the next page of records, call `fetchNextPage`.
          // If there are more records, the above fn will get called again.
          // If there are no more records, the second fn (below) will get called.
          fetchNextPage();
        },
        err => {
          if (err) {
            console.error(err);
          }
          const players = allRecords.map(record => {
            return Object.assign(record.fields, { id: record.id });
          });
          console.log(players);
          res.json(players);
        }
      );
  })
  .post((req, res, next) => {
    base("Info").create(req.body, (err, record) => {
      if (err) {
        console.error(err);
        return;
      }
      console.log(record.getId());
      res.send();
    });
  });

router
  .route("/players/:id")
  .get((req, res, next) => {
    base("Info").find(req.params.id, (err, record) => {
      if (err) {
        console.error(err);
        return;
      }
      res.json(Object.assign(record.fields, { id: record.id }));
    });
  })
  .put((req, res, next) => {
    base("Info").update(req.params.id, req.body, (err, record) => {
      if (err) {
        console.error(err);
        return;
      }
      res.json(Object.assign(record.fields, { id: record.id }));
    });
  })
  .delete((req, res, next) => {
    base("Info").destroy(req.params.id, (err, deletedRecord) => {
      if (err) {
        console.error(err);
        return;
      }
      console.log("Deleted record", deletedRecord.id);
      res.send();
    });
  });

module.exports = router;

// base("Info").find("rec7kAa34bcVk1p2u", function(err, record) {
//   if (err) {
//     console.error(err);
//     return;
//   }
//   console.log(record);
// });

// base("Info").create(
//   {
//     Name: "Finn",
//     Level: 20
//   },
//   function(err, record) {
//     if (err) {
//       console.error(err);
//       return;
//     }
//     console.log(record.getId());
//   }
// );
