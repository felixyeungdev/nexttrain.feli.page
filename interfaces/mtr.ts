interface LightRailRoute {
    train_length: number;
    arrival_departure: "D" | "A";
    dest_en: string;
    dest_ch: string;
    time_en: string;
    time_ch: string;
    route_no: string;
    stop: number;
}

interface LightRailPlatform {
    route_list: LightRailRoute[];
    platform_id: number;
}

export interface LightRailResponse {
    platform_list: LightRailPlatform[];
    status: 1 | 0;
    system_time: string;
}

//

interface MTRResponseData {
    curr_time: string;
    sys_time: string;
    UP: MTRTrainETA[];
    DOWN: MTRTrainETA[];
}

interface MTRTrainETA {
    ttnt: string;
    valid: string;
    plat: string;
    time: string;
    source: string;
    dest: string;
    seq: string;
}

export interface MTRResponse {
    status: number;
    message: string;
    curr_time: string;
    sys_time: string;
    isdelay: "Y" | "N";
    data: {
        [key: string]: MTRResponseData;
    };
}
