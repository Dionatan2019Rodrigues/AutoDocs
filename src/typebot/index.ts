import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

const TOKEN = process.env.TYPEBOT_API_TOKEN;
const URL = process.env.TYPEBOT_URL;
const WORKSPACE_ID = process.env.TYPEBOT_WORKSPACE_ID;
const TYPEBOT_ID = process.env.TYPEBOT_ID;

async function main() {
  try {
    const response = await axios.get(
      `${URL}/api/v1/typebots/${TYPEBOT_ID}/results?workspaceId=${WORKSPACE_ID}`,
      {
        headers: {
          Authorization: `Bearer ${TOKEN}`,
        },
      }
    );

    console.log("Typebots encontrados:\n");
    console.log(JSON.stringify(response.data, null, 2));
  } catch (error: any) {
    console.error("Erro:");

    if (error.response) {
      console.error(JSON.stringify(error.response.data, null, 2));
    } else {
      console.error(error.message);
    }
  }
}

main();