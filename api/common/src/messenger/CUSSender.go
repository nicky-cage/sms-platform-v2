package messenger

// CUGSender 发送
type CUGSender struct {
	ProductType string
	ChannelName string
	IPList      []string
	Port        int
	Account     string
	Password    string
	TPS         int
	ChannelType string
	Path        string
	Direction   string
}

// CUG 一
var CUG = CUGSender{
	ProductType: "ADMAL Marketing",
	ChannelName: "",
	ChannelType: "SMPP",
	IPList: []string{
		"203.160.95.115",
		"47.242.200.116",
	},
	Port:      2875,
	Account:   "ADMALCugstd",
	Password:  "8z5XkD1p",
	TPS:       10,
	Direction: "",
}

// CUG2 二
var CUG2 = CUGSender{
	ProductType: "MKT Product",
	ChannelName: "Gaming Curacao/MKT ROUTE",
	ChannelType: "HTTP",
	Path:        "/api",
	IPList: []string{
		"203.160.95.115",
		"47.242.200.116",
	},
	Port:      8001,
	Account:   "GCCugMKT",
	Password:  "F)##8sB7t",
	TPS:       100,
	Direction: "",
}

// CUG3 三
var CUG3 = CUGSender{
	ProductType: "MKT Product",
	ChannelName: "MKT Product_HTTP_JK",
	ChannelType: "HTTP",
	Path:        "/api",
	IPList: []string{
		"203.160.95.115",
		"47.242.200.116",
	},
	Port:      8001,
	Account:   "Debcast12mktjk",
	Password:  "nUD7k3du",
	TPS:       50,
	Direction: "",
}

// CUG4 四
// IP www.jkssthoviouluoba.com
// port  5520
// account 783487
// password 9ae188c5
// tps 20
// max connection 2
var CUG4 = CUGSender{
	ProductType: "JKSS",
	ChannelName: "jkssthoviouluoba",
	ChannelType: "SMPP",
	IPList: []string{
		"www.jkssthoviouluoba.com",
	},
	Port:      5520,
	Account:   "783487",
	Password:  "9ae188c5",
	TPS:       20,
	Direction: "",
}

// CUG5 五
var CUG5 = CUGSender{
	ProductType: "MKT_LT",
	ChannelName: "MKT_LT",
	ChannelType: "SMPP",
	Path:        "/api",
	IPList: []string{
		"203.160.95.115",
		"47.242.200.116",
		"100.21.8.223",
		"3.39.157.142",
	},
	Port:      8001,
	Account:   "Deb1219mktm",
	Password:  "9d7rP5KL",
	TPS:       50,
	Direction: "",
}

// Channels 渠道
var Channels = map[string]CUGSender{
	"CUG_SMPP":    CUG,
	"CUG_HTTP":    CUG2,
	"CUG_HTTP_JK": CUG3,
	"JKS_SMPP":    CUG4,
	"MKT_HTTP_LT": CUG5,
}

// Server 服务器
type Server struct {
	CodeList map[string]CUGSender
}

// Product Type产品类型	MKT Product_HTTP channel_Mobile
// Channel Name通道名称	DEBCAST_MKT_HTTP_Mobile
// IP site 	203.160.95.115, 47.242.200.116	100.21.8.223 3.39.157.142
// Port端口号	8001
// Account账户	Deb1219mktm
// Password密码	9d7rP5KL
// TPS速率	50

// SMSServer 服务器
var SMSServer = Server{
	CodeList: map[string]CUGSender{
		"CUG_SMPP":    CUG,
		"CUG_HTTP":    CUG2,
		"CUG_HTTP_JK": CUG3,
		"JKS_SMPP":    CUG4,
		"LTS_HTTP":    CUG5,
	},
}
