CMD:dsave(playerid, params[])
{
    new swhat[12], string[126], desc[126], Float:X, Float:Y, Float:Z, Float:A, vw = GetPlayerVirtualWorld(playerid), interior = GetPlayerInterior(playerid);
    if(sscanf(params, "s[12]s[126]", swhat, desc)) return SendClientMessage(playerid, -1, "DEBUG: /dsave [position] [description]");

    if(strcmp(swhat, "position", true) == 0)
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
        {
            new File:fdebug = fopen("save.txt", io_append);
            new vehicleid = GetPlayerVehicleID(playerid);
            GetVehiclePos(vehicleid, X, Y, Z);
            GetVehicleZAngle(vehicleid, A);
            format(string, sizeof(string), "VEHICLE POSITION: %f, %f, %f, %f // %s\r\n", X, Y, Z, A, desc);
            fwrite(fdebug, string);
            fclose(fdebug);
            SendClientMessage(playerid, -1, "DEBUG: Your vehicles position has been saved to debug.txt");
            return 1;
        }
        else if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
        {
            new File:fdebug = fopen("save.txt", io_append);
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, A);
            format(string, sizeof(string), "ON FOOT POSITION: %f, %f, %f, %f, %d, %d // %s\r\n", X, Y, Z, A, vw, interior, desc);
            fwrite(fdebug, string);
            fclose(fdebug);
            SendClientMessage(playerid, -1, "INFO: Your on-foot position has been saved to debug.txt");
            return 1;
        }
        else
        {
            SendClientMessage(playerid, -1, "INFO: You are not on-foot or in any vehicle.");
            return 1;
        }
    }
    return 1;
}

