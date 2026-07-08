import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

const API_KEY = process.env.FORMBRICKS_API_KEY;
const URL = process.env.FORMBRICKS_URL;
const SURVEY_ID = process.env.FORMBRICKS_SURVEY_ID;

async function main() {
  try {
    const response = await axios.get(
      `${URL}/api/v2/management/responses?surveyId=${SURVEY_ID}`,
      {
        headers: {
          "x-api-key": API_KEY,
        },
      }
    );

    console.log("Respostas encontradas:\n");

    response.data.data.forEach((submission: any, index: number) => {
      console.log(`========== Resposta ${index + 1} ==========\n`);
      console.log(submission.data);
      console.log();
    });
  } catch (error: any) {
    console.error("Erro:");

    if (error.response) {
      console.error(error.response.data);
    } else {
      console.error(error.message);
    }
  }
}

main();