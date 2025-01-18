const mongoose = require("mongoose");

const ImageDetailsScehma = new mongoose.Schema(
  {
   image:String
  },
  {
    collection: "ImageDetails",
  }
);

<<<<<<< HEAD
mongoose.model("ImageDetails", ImageDetailsScehma);
=======
mongoose.model("ImageDetails", ImageDetailsScehma);
>>>>>>> origin/image-uploader
