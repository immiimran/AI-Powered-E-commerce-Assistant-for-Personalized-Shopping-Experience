const functions = require("firebase-functions");
const vision = require("@google-cloud/vision");
const client = new vision.ImageAnnotatorClient();

// HTTP function for label detection
exports.visionLabel = functions.https.onRequest(async (req, res) => {
  try {
    if (req.method !== "POST") {
      return res.status(405).send({ error: "Method not allowed" });
    }
    const body = req.body;
    const imageUrl = body.imageUrl;
    if (!imageUrl) {
      return res.status(400).send({ error: "imageUrl is required" });
    }

    // Call Vision API
    const [result] = await client.labelDetection(imageUrl);
    const labels = (result.labelAnnotations || []).map(l => l.description);

    // Return top labels (lowercased)
    res.json({ labels: labels.map(x => x.toLowerCase()) });
  } catch (err) {
    console.error("vision error:", err);
    res.status(500).send({ error: err.toString() });
  }
});
