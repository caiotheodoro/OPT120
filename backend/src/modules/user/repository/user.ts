import { Pool } from "pg";
import { CreateUserDTO, UpdateUserDTO } from "../dtos";
import { UserEntity } from "../../../@types/entities";
import { UserInterface } from "./user.interface";


export class UserRepository implements UserInterface {
  #pool: Pool;

  constructor(pool: Pool) {
    this.#pool = pool;
  }

  async getUsers(): Promise<UserEntity[]> {
    const response = await this.#pool.query('SELECT * FROM "user"  ORDER BY id ASC');
    return response.rows;
  }

  async createUser({ name, email, password }: CreateUserDTO): Promise<void> {
    await this.#pool.query(
      `INSERT INTO "user" (name, email, password) VALUES ($1, $2, $3)`,
      [name, email, password],
    );
  }

  async getUserById(id:string): Promise<UserEntity> {
    const response = await this.#pool.query('SELECT * FROM "user" WHERE id = $1', [
      id,
    ]);
    return response.rows[0];
  }

  async updateUser({ id, name, email, password }: UpdateUserDTO) {
    await this.#pool.query(
      `UPDATE "user" SET name = $1, email = $2, password = $3 WHERE id = $4`,
      [name, email, password, id],
    );
  }

  async deleteUser(id:string) {
    await this.#pool.query('DELETE FROM "user_activity" WHERE userId = $1', [
      id,
    ]);
    await this.#pool.query('DELETE FROM "user" WHERE id = $1', [id]);
  }
}