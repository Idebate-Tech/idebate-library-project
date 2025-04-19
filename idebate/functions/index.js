///**
// * Import function triggers from their respective submodules:
// *
// * const {onCall} = require("firebase-functions/v2/https");
// * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
// *
// * See a full list of supported triggers at https://firebase.google.com/docs/functions
// */
//
//const {onRequest} = require("firebase-functions/v2/https");
//const logger = require("firebase-functions/logger");
//
//// Create and deploy your first functions
//// https://firebase.google.com/docs/functions/get-started
//
//// exports.helloWorld = onRequest((request, response) => {
////   logger.info("Hello logs!", {structuredData: true});
////   response.send("Hello from Firebase!");
//// });


const functions = require("firebase-functions");
const { google } = require("googleapis");
const cors = require("cors")({ origin: true });
const sheets = google.sheets("v4");

const auth = new google.auth.GoogleAuth({
  keyFile: "cultivated-era-430806-c1-cf33a8ead238.json", // Replace with your actual key file name
  scopes: ["https://www.googleapis.com/auth/spreadsheets"],
});

exports.sheetProxy = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    try {
      const client = await auth.getClient();
      const spreadsheetId = "cf33a8ead238615d9ff6478d70d9f744fe3648a7"; // Replace with your actual ID

      const {
        action,
        sheet,
        values,
        rowIndex,
        columnIndex,
        query,
        userId,
        field,
        match,
        key,
      } = req.body;

      if (!sheet || !action) {
        return res.status(400).json({ error: "sheet and action are required." });
      }

      // READ full sheet
      if (action === "read") {
        const result = await sheets.spreadsheets.values.get({
          auth: client,
          spreadsheetId,
          range: sheet,
        });
        return res.status(200).json(result.data);
      }

      // APPEND row
      if (action === "append") {
        if (!Array.isArray(values)) {
          return res.status(400).json({ error: "values must be an array of arrays." });
        }
        await sheets.spreadsheets.values.append({
          auth: client,
          spreadsheetId,
          range: sheet,
          valueInputOption: "USER_ENTERED",
          insertDataOption: "INSERT_ROWS",
          requestBody: { values },
        });
        return res.status(200).json({ success: true });
      }

      // UPDATE single cell
      if (action === "updateCell") {
        if (!rowIndex || !columnIndex || !values) {
          return res.status(400).json({ error: "rowIndex, columnIndex and values are required for updateCell." });
        }

        await sheets.spreadsheets.values.update({
          auth: client,
          spreadsheetId,
          range: `${sheet}!${columnIndex}${rowIndex}`,
          valueInputOption: "USER_ENTERED",
          requestBody: {
            values: [[values]],
          },
        });

        return res.status(200).json({ success: true });
      }

      // DELETE row by matching a field
      if (action === "deleteRow") {
        const sheetMeta = await sheets.spreadsheets.values.get({
          auth: client,
          spreadsheetId,
          range: sheet,
        });

        const rows = sheetMeta.data.values;
        const rowToDelete = rows.findIndex(row => row.length > key && row[key] === match);
        if (rowToDelete === -1) {
          return res.status(404).json({ error: "Row not found" });
        }

        await sheets.spreadsheets.batchUpdate({
          auth: client,
          spreadsheetId,
          requestBody: {
            requests: [
              {
                deleteDimension: {
                  range: {
                    sheetId: await getSheetIdByName(spreadsheetId, sheet, client),
                    dimension: "ROWS",
                    startIndex: rowToDelete,
                    endIndex: rowToDelete + 1,
                  },
                },
              },
            ],
          },
        });

        return res.status(200).json({ success: true });
      }

      return res.status(400).json({ error: "Unknown action" });
    } catch (error) {
      console.error("Proxy Error:", error.message);
      return res.status(500).json({ error: error.message });
    }
  });
});

async function getSheetIdByName(spreadsheetId, sheetName, client) {
  const sheetsApi = google.sheets({ version: "v4", auth: client });
  const spreadsheet = await sheetsApi.spreadsheets.get({ spreadsheetId });
  const sheet = spreadsheet.data.sheets.find(s => s.properties.title === sheetName);
  return sheet ? sheet.properties.sheetId : null;
}

