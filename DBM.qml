import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id: dbm

    Component.onCompleted: {
        createTable();
        insertAllStationsToLMFromDB();
    }

    // Global constructs
    property var stationsListModel: stationsListModel

    /*** General Usage Begin ***/
    function insertStation(station)
    {
        insertStationToLM(station);
        insertStationToDB(station);
    }

    function updateStation(station)
    {
        updateStationInLM(station);
        updateStationInDB(station);
    }

    function removeStation(station)
    {
        removeStationFromLM(station);
        removeStationFromDB(station);
    }

    /*** Generel Usage End ***/

    /*** List Model Begin ***/
    ListModel {
        id: stationsListModel
    }

    function insertStationToLM(station)
    {
        stationsListModel.append(station);
    }

    function findIndexInLMByStationID(stationID)
    {
        for (var i = 0; i < stationsListModel.count; i++)
        {
            if (stationID === stationsListModel.get(i).id)
            {
                return i;
            }
        }
        return -1;
    }

    function updateStationInLM(station)
    {
        var index = findIndexInLMByStationID(station.id)
        stationsListModel.set(index, station)
    }

    function removeStationFromLM(station)
    {
        var index = findIndexInLMByStationID(station.id)
        stationsListModel.remove(index)
    }

    function getStationFromLM(listIndex)
    {
        var index = listIndex
        var id = stationsListModel.get(index).id;
        var name = stationsListModel.get(index).name;
        var url = stationsListModel.get(index).url;
        var image = stationsListModel.get(index).image;
        var data = {
            'index': index,
            'id': id,
            'name': name,
            'url': url,
            'image': image
        }
        return data
    }
    /*** List Model End ***/

    /*** Database Begin ***/
    function createTable()
    {
        var db = LocalStorage.openDatabaseSync("internetRadioPlayerDB", "1.0", "Internet Radio Player Local DB", 1000000);
        try {
            db.transaction(
                function(tx)
                {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Stations(
                                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                                    name TEXT,
                                    url TEXT,
                                    image TEXT
                                    )'
                                  );
                }
            );
        }
        catch (err)
        {
            console.log("Error creating 'Stations' table in Internet Radio Player Local DB: " + err);
        }
    }

    function insertStationToDB(station)
    {
        var db = LocalStorage.openDatabaseSync("internetRadioPlayerDB", "1.0", "Internet Radio Player Local DB", 1000000);
        db.transaction(
            function(tx)
            {
                try
                {
                    tx.executeSql('INSERT INTO Stations(name, url, image) VALUES(?, ?, ?)',
                                  [station.name,
                                   station.url,
                                   station.image]
                                  );
                    console.log("Station is added: (?, ?)", station.name, station.url);
                }
                catch (err)
                {
                    console.log("Error inserting to 'Stations' table in Internet Radio Player Local DB: " + err);
                }
            }
        );
    }

    function updateStationInDB(station)
    {
        var db = LocalStorage.openDatabaseSync("internetRadioPlayerDB", "1.0", "Internet Radio Player Local DB", 1000000);
        try
        {
            db.transaction(
                function(tx)
                {
                    tx.executeSql('UPDATE Stations SET name=?,
                                                       url=?,
                                                       image=?
                                                       WHERE id=?',
                                 [station.name,
                                  station.url,
                                  station.image,
                                  station.id]
                                  );
                }
            );
            console.log("Station updated in 'Stations 'table in in Internet Radio Player Local DB");
        }
        catch(err)
        {
            console.log("Error updating station in 'Stations' table in Internet Radio Player Local DB");
        }
    }

    function removeStationFromDB(station)
    {
        var db = LocalStorage.openDatabaseSync("internetRadioPlayerDB", "1.0", "Internet Radio Player Local DB", 1000000);
        try
        {
            db.transaction(
                function(tx)
                {
                    tx.executeSql('DELETE FROM Stations WHERE id=?',
                                  [station.id]
                                );
                }
            );
            console.log("Station deleted from 'Stations' table in Internet Radio Player Local DB");
        }
        catch(err)
        {
            console.log("Error deleting from 'Stations' table in Internet Radio Player Local DB: " + err);
        }
    }

    function getStationFromDB(stationID)
    {
        var stationData;
        var db = LocalStorage.openDatabaseSync("internetRadioPlayerDB", "1.0", "Internet Radio Player Local DB", 1000000);
        db.transaction(
            function (tx)
            {
                var station = tx.executeSql('SELECT * FROM Stations WHERE id=?',
                                     [stationID]
                                     );
                stationData = station2Data(station.rows.item(0));
            }
        );
        return stationData;
    }

    function insertAllStationsToLMFromDB()
    {
        var db = LocalStorage.openDatabaseSync("internetRadioPlayerDB", "1.0", "Internet Radio Player Local DB", 1000000);
        db.transaction(
            function (tx)
            {
                var stations = tx.executeSql('SELECT * FROM Stations');
                for (var i = 0; i < stations.rows.length; i++)
                {
                    var stationData = station2Data(stations.rows.item(i));
                    insertStationToLM(stationData);
                }
            }
        );
    }

    function station2Data(station)
    {
        return {
            'id': station.id,
            'name': station.name,
            'url': station.url,
            'image': station.image
        };
    }
    /*** Database End ***/
}
