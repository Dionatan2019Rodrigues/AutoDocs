import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

const TOKEN = process.env.BASEROW_TOKEN;
const TABLE_ID = process.env.BASEROW_TABLE_ID;
const URL = process.env.BASEROW_URL;

async function main() {
  try {
    const response = await axios.get(
      `${URL}/api/database/rows/table/${TABLE_ID}/?user_field_names=true`,
      {
        headers: {
          Authorization: `Token ${TOKEN}`,
        },
      }
    );

    console.log("Dados encontrados:");
    console.log(JSON.stringify(response.data, null, 2));
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