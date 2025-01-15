const express = require("express");
const app = express();
const mongoose = require("mongoose");
app.use(express.json());
const cors = require("cors");
const path = require('path');
app.use(cors());


//mongodb connection
mongoose.connect('mongodb://localhost:27017/multerflutter') // Consider using localhost
  .then(() => {
    console.log('Connected to MongoDB');
    
    // Start the server only after a successful database connection
    app.listen(3000, () => {
        console.log("Server is running on port 3000");
    });
  })
  .catch((error) => {
    console.error('Error connecting to MongoDB', error);
  });
//importing schema
require("./imageDetails");
const Images = mongoose.model("ImageDetails");

app.get("/", async (req, res) => {
  res.send("Success!!!!!!");
});

app.listen(5000, () => {
  console.log("Server Started");
});

////////////////////////////////////////////////////////////

const multer = require("multer");

const storage = multer.diskStorage({ // yetekebelewn image yetugar store endemiyadergew nw yemiyaweraw 
  destination: function (req, file, cb) {
    cb(null, "../src/multer/images/");
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = new Date().toISOString().replace(/[-:.]/g, "").slice(0, -5); // Format: YYYYMMDDHHMMSS
        const fileExtension = path.extname(file.originalname); // Get the file extension
        cb(null, uniqueSuffix + fileExtension);
    
    // cb(null, uniqueSuffix + file.originalname);
  },
});

const upload = multer({ storage: storage });
/**
 * upload.single("image") yhe yemilew single image bcha take adrg ena mtkebelew image bemil name nw 
 */

app.post("/upload-image", upload.single("image"), async (req, res) => {
  console.log(req.body);
  const imageName = req.file.filename;

  try {
    await Images.create({ image: imageName });
    res.json({ status: "ok" });
  } catch (error) {
    res.json({ status: error });
  }
});

app.get("/get-image", async (req, res) => {
  try {
    Images.find({}).then((data) => {
      res.send({ status: "ok", data: data });
    });
  } catch (error) {
    res.json({ status: error });
  }
});
