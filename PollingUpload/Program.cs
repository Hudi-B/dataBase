using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;

namespace PollingDataUploader
{
    class Program
    {
        static void Main(string[] args)
        {
            string filePath = "E:\\Git\\dataBase\\PollingUpload\\BAZmegye.tsv";
            string connectionString = "server=localhost;user=root;password=;database=pollingdb";

            string[] lines = File.ReadAllLines(filePath, Encoding.UTF8);

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                connection.Open();
                int tempStatus = 0;

                foreach (string line in lines.Skip(1))
                {
                    string[] parts = line.Split('\t');

                    int settlementId = GetOrInsertId(connection, "Settlement", "SettlementName", parts[1]);
                    int pollingAreaId = GetOrInsertId(connection, "PollingArea", "PollingAreaAddress", parts[4]);
                    int commonGroundId = GetOrInsertId(connection, "CommonGround", "CommonGroundName", parts[8]);
                    int commonGroundTypeId = GetOrInsertId(connection, "CommonGroundType", "CommonGroundType", parts[9]);

                    InsertDataIntoPolling(connection, settlementId, int.Parse(parts[2]), pollingAreaId,
                      parts[5] == "N" ? 0 : 1, parts[6] == "I" ? 1 : 0, int.Parse(parts[7]),
                      commonGroundId, commonGroundTypeId, parts[10], parts[11], parts[12], parts[13]);

                    tempStatus++;
                    Console.WriteLine($"Inserted data for line({tempStatus}/223773): " + line);
                }

                connection.Close();
            }

            Console.WriteLine("Data insertion completed.");
        }

        static int GetOrInsertId(MySqlConnection connection, string tableName, string columnName, string value)
        {
            string query = $"SELECT {tableName}Id FROM {tableName} WHERE {columnName} = @Value";
            MySqlCommand command = new MySqlCommand(query, connection);
            command.Parameters.AddWithValue("@Value", value);

            object result = command.ExecuteScalar();

            if (result != null)
            {
                return Convert.ToInt32(result);
            }
            else
            {
                query = $"INSERT INTO {tableName} ({columnName}) VALUES (@Value); SELECT LAST_INSERT_ID();";
                command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@Value", value);

                return Convert.ToInt32(command.ExecuteScalar());
            }
        }

        static void InsertDataIntoPolling(MySqlConnection connection, int settlementId, int oevk, int pollingAreaId,
                                  int nominated, int handiAccessible, int pir, int commonGroundId, int commonGroundTypeId,
                                  string houseNumber, string building, string staircase, string gateCode)
        {
            string query = @"INSERT INTO Polling (SettlementId, Oevk, PollingAreaId, Nominated, HandiAccessible, Pir,
                     CommonGroundId, CommonGroundTypeId, HouseNumber, Building, Staircase, GateCode) VALUES
                     (@SettlementId, @Oevk, @PollingAreaId, @Nominated, @HandiAccessible, @Pir, @CommonGroundId, @CommonGroundTypeId,
                     @HouseNumber, @Building, @Staircase, @GateCode)";

            MySqlCommand command = new MySqlCommand(query, connection);
            command.Parameters.AddWithValue("@SettlementId", settlementId);
            command.Parameters.AddWithValue("@Oevk", oevk);
            command.Parameters.AddWithValue("@PollingAreaId", pollingAreaId);
            command.Parameters.AddWithValue("@Nominated", nominated);
            command.Parameters.AddWithValue("@HandiAccessible", handiAccessible);
            command.Parameters.AddWithValue("@Pir", pir);
            command.Parameters.AddWithValue("@CommonGroundId", commonGroundId);
            command.Parameters.AddWithValue("@CommonGroundTypeId", commonGroundTypeId);
            command.Parameters.AddWithValue("@HouseNumber", houseNumber);
            command.Parameters.AddWithValue("@Building", building);
            command.Parameters.AddWithValue("@Staircase", staircase);
            command.Parameters.AddWithValue("@GateCode", gateCode);

            command.ExecuteNonQuery();
        }
    }
}
