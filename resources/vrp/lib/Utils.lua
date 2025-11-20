-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
SERVER = IsDuplicityVersion()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEVELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Levels = { 0,270,580,940,1350,1820,2360,2980,3690,4500,5440,6520,7760,9180,10810,12690,14850,17330,20180,23450,27210,31540,36510,42230,48810,56370,65060,75060,86550,99999 }
local LevelsPainel = { 0,270,580,940,1350,1820,2360,2980,3690,4500,5440,6520,7760,9180,10810,12690,14850,17330,20180,23450,27210,31540,36510,42230,48810,56370,65060,75060,86550,99999 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSCATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
function ClassCategory(Experience)
	local Return = 1

	for Table = 1,#Levels do
		if Experience >= Levels[Table] then
			Return = Table
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLELEVEL
-----------------------------------------------------------------------------------------------------------------------------------------
function TableLevel()
	return Levels
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLELEVELPAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
function TableLevelPainel()
	return LevelsPainel
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAINS
-----------------------------------------------------------------------------------------------------------------------------------------
function Contains(Table,Value)
	for _,v in ipairs(Table) do
		if v == Value then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPTYSPACE
-----------------------------------------------------------------------------------------------------------------------------------------
function EmptySpace(Message)
	return Message:gsub("%s+","")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRSTTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function FirstText(Message)
    return (Message:match("^(%S+)") or ""):sub(1,1):upper()..(Message:match("^(%S+)") or ""):sub(2):lower()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANGUINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Sanguine(Number)
	local Types = { "A+","B+","A-","B-" }

	return Types[Number]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLE.MAXN
-----------------------------------------------------------------------------------------------------------------------------------------
function table.maxn(Table)
	local Number = 0

	for Index,_ in pairs(Table) do
		local Next = tonumber(Index)
		if Next and Next > Number then
			Number = Next
		end
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COUNTTALBE
-----------------------------------------------------------------------------------------------------------------------------------------
function CountTable(Table)
	local Number = 0

	for _ in pairs(Table) do
		Number = Number + 1
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODULE
-----------------------------------------------------------------------------------------------------------------------------------------
local modules = {}
function module(Resource,Patch)
	if not Patch then
		Patch = Resource
		Resource = "vrp"
	end

	local Key = Resource..Patch
	local Module = modules[Key]
	if Module then
		return Module
	else
		local File = LoadResourceFile(Resource,Patch..".lua")
		if File then
			local Float = load(File,Resource.."/"..Patch..".lua")
			if Float then
				local Accept,Result = xpcall(Float,debug["traceback"])
				if Accept then
					modules[Key] = Result

					return Result
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAIT
-----------------------------------------------------------------------------------------------------------------------------------------
local function wait(self)
	local rets = Citizen.Await(self.p)
	if not rets and self.r then
		rets = self.r
	end

	return table.unpack(rets,1,table.maxn(rets))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARETURN
-----------------------------------------------------------------------------------------------------------------------------------------
local function areturn(self,...)
	self.r = {...}
	self.p:resolve(self.r)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNC
-----------------------------------------------------------------------------------------------------------------------------------------
function async(func)
	if func then
		Citizen.CreateThreadNow(func)
	else
		return setmetatable({ wait = wait, p = promise.new() },{ __call = areturn })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARSEINT
-----------------------------------------------------------------------------------------------------------------------------------------
function parseInt(Number,Force)
	Number = tonumber(Number) or 0
	if Force and Number <= 0 then
		Number = 1
	end

	return math.floor(Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANITIZESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function sanitizeString(String,Characteres)
	return String:gsub("[^"..Characteres.."]","")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITSTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function splitString(Full,Symbol)
	local Table = {}

	if not Symbol then
		Symbol = "-"
	end

	for Full in string.gmatch(Full,"([^"..Symbol.."]+)") do
		Table[#Table + 1] = Full
	end

	return Table
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITONE
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitOne(Name,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[1]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITBOOLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitBoolean(Name,String,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[1] == String and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITTWO
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitTwo(Name,Symbol)
	if not Symbol then
		Symbol = "-"
	end

	return splitString(Name,Symbol)[2]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLITUNIQUE
-----------------------------------------------------------------------------------------------------------------------------------------
function SplitUnique(Item)
	local Name = splitString(Item,"-")

	return Name[1]..":"..Name[3]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPTIMIZE
-----------------------------------------------------------------------------------------------------------------------------------------
function Optimize(Number)
	return math.ceil(Number * 100) / 100
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOTTED
-----------------------------------------------------------------------------------------------------------------------------------------
function Dotted(Value)
	local Value = parseInt(Value)
	local Left,Number,Right = string.match(Value,"^([^%d]*%d)(%d*)(.-)$")
	return Left..(Number:reverse():gsub("(%d%d%d)","%1."):reverse())..Right
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPLETETIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function CompleteTimers(Seconds)
	local Seconds = parseInt(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds % 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds % 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds % 60

	if Days > 0 then
		if Hours > 0 then
			if Minutes > 0 then
				return string.format("%d Dias, %d Horas e %d Minutos",Days,Hours,Minutes)
			else
				return string.format("%d Dias e %d Horas",Days,Hours)
			end
		else
			return string.format("%d Dias",Days)
		end
	elseif Hours > 0 then
		if Minutes > 0 then
			if Seconds > 0 then
				return string.format("%d Horas, %d Minutos e %d Segundos",Hours,Minutes,Seconds)
			else
				return string.format("%d Horas e %d Minutos",Hours,Minutes)
			end
		else
			return string.format("%d Horas",Hours)
		end
	elseif Minutes > 0 then
		if Seconds > 0 then
			return string.format("%d Minutos e %d Segundos",Minutes,Seconds)
		else
			return string.format("%d Minutos",Minutes)
		end
	else
		return string.format("%d Segundos",Seconds)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONES
-----------------------------------------------------------------------------------------------------------------------------------------
local Bones = {
	[11816] = "Pelvis",
	[58271] = "Coxa Esquerda",
	[63931] = "Panturrilha Esquerda",
	[14201] = "Pe Esquerdo",
	[2108] = "Dedo do Pe Esquerdo",
	[65245] = "Pe Esquerdo",
	[57717] = "Pe Esquerdo",
	[46078] = "Joelho Esquerdo",
	[51826] = "Coxa Direita",
	[36864] = "Panturrilha Direita",
	[52301] = "Pe Direito",
	[20781] = "Dedo do Pe Direito",
	[35502] = "Pe Direito",
	[24806] = "Pe Direito",
	[16335] = "Joelho Direito",
	[23639] = "Coxa Direita",
	[6442] = "Coxa Direita",
	[57597] = "Espinha Cervical",
	[23553] = "Espinha Toraxica",
	[24816] = "Espinha Lombar",
	[24817] = "Espinha Sacral",
	[24818] = "Espinha Cocciana",
	[64729] = "Escapula Esquerda",
	[45509] = "Braco Esquerdo",
	[61163] = "Antebraco Esquerdo",
	[18905] = "Mao Esquerda",
	[18905] = "Mao Esquerda",
	[26610] = "Dedo Esquerdo",
	[4089] = "Dedo Esquerdo",
	[4090] = "Dedo Esquerdo",
	[26611] = "Dedo Esquerdo",
	[4169] = "Dedo Esquerdo",
	[4170] = "Dedo Esquerdo",
	[26612] = "Dedo Esquerdo",
	[4185] = "Dedo Esquerdo",
	[4186] = "Dedo Esquerdo",
	[26613] = "Dedo Esquerdo",
	[4137] = "Dedo Esquerdo",
	[4138] = "Dedo Esquerdo",
	[26614] = "Dedo Esquerdo",
	[4153] = "Dedo Esquerdo",
	[4154] = "Dedo Esquerdo",
	[60309] = "Mao Esquerda",
	[36029] = "Mao Esquerda",
	[61007] = "Antebraco Esquerdo",
	[5232] = "Antebraco Esquerdo",
	[22711] = "Cotovelo Esquerdo",
	[10706] = "Escapula Direita",
	[40269] = "Braco Direito",
	[28252] = "Antebraco Direito",
	[57005] = "Mao Direita",
	[58866] = "Dedo Direito",
	[64016] = "Dedo Direito",
	[64017] = "Dedo Direito",
	[58867] = "Dedo Direito",
	[64096] = "Dedo Direito",
	[64097] = "Dedo Direito",
	[58868] = "Dedo Direito",
	[64112] = "Dedo Direito",
	[64113] = "Dedo Direito",
	[58869] = "Dedo Direito",
	[64064] = "Dedo Direito",
	[64065] = "Dedo Direito",
	[58870] = "Dedo Direito",
	[64080] = "Dedo Direito",
	[64081] = "Dedo Direito",
	[28422] = "Mao Direita",
	[6286] = "Mao Direita",
	[43810] = "Antebraço Direito",
	[37119] = "Antebraço Direito",
	[2992] = "Cotovelo Direito",
	[39317] = "Pescoco",
	[31086] = "Cabeca",
	[12844] = "Cabeca",
	[65068] = "Rosto"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONE
-----------------------------------------------------------------------------------------------------------------------------------------
function Bone(Number)
	return Bones[Number] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDPERCENTAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function RandPercentage(Table)
	local PoolSize = 0
	for Number = 1,#Table do
		PoolSize = PoolSize + Table[Number]["Chance"]
	end

	local Selected = math.random(1,PoolSize)
	for Index,v in pairs(Table) do
		Selected = Selected - v["Chance"]

		if v["Min"] and v["Max"] then
			Table[Index]["Valuation"] = math.random(v["Min"],v["Max"])
		end

		if (Selected <= 0) then
			return Table[Index]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function GenerateString(Format)
	local Message = ""
	local LenByte = string.byte("A")
	local NumByte = string.byte("0")

	for Number = 1,#Format do
		local Lenght = string.sub(Format,Number,Number)
    	if Lenght == "D" then
    		Message = Message..string.char(NumByte + math.random(0,9))
		elseif Lenght == "L" then
			Message = Message..string.char(LenByte + math.random(0,25))
		else
			Message = Message..Lenght
		end
	end

	return Message
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BASE64
-----------------------------------------------------------------------------------------------------------------------------------------
local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function Base64(data)
	return ((data:gsub(".",function(x)
		local r, b = "", x:byte()
		for i = 8,1,-1 do
			r = r..(b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
		end

		return r
	end).."0000"):gsub("%d%d%d?%d?%d?%d?",function(x)
		if (#x < 6) then return "" end
		local c = 0
			for i = 1, 6 do
			c = c + (x:sub(i,i) == "1" and 2 ^ (6 - i) or 0)
		end

		return b:sub(c + 1,c + 1)
	end)..({ "","==","=" })[#data % 3 + 1])
end

-- This file was protected using Luraph Obfuscator v14.4.1 [https://lura.ph/]
return({i=function(A,A)return{A};end,iG=function(A,j,M,J,O,F,S)local X;if not(F<=0X1.3Cp6)then if F~=85.0 then(S[12])[0X6]=A.xG;return 0x1Bfa,F,J;else J,F=A:mG(M,O,J,F);end;else if F~=48.0 then(S[28])[0]=({[3]=1,[1]=S[0x0013]({A.c},{[A.G]=function(M,M)return _ENV;end,[A.Q]=function(M,M,M)_ENV=(M);end})});if not(not O[29758])then F=O[0X743e];else O[3717]=(-125+((O[0X045D0]&O[24303]~O[0X2e2C])-O[0X539b]==O[24440]and O[0X37c1]or O[3226]));O[11808]=-34142001+(((O[32642]>>O[20619]==A.q[4]and A.q[7]or O[0X6C6e])==O[0X539B]and O[6302]or O[0X189E])~A.q[7]);F=64+(((O[18677]|O[0X7331])~O[23732])<<O[0X5eeF]<O[0x6C6E]and O[0X73aD]or A.q[1]);(O)[29758]=F;end;else if S[0x24]==j then if-(75~=0x5f)then for j=0x16,0x92,0X2F do X=A:zG(S,j);if X~=nil then return{A.K(X)},j,J;end;end;end;end;if not O[0x2e2C]then O[0X539b]=-60129542122+(((O[23732]-O[0X4193]>O[0X6C6E]and A.q[0x8]or O[0X4193])==O[23732]and O[0X45D0]or O[18237])<<O[0X508b]);F=(-0X35405Bc2+((O[0X5eEF]-O[16680]-F~O[0X4f6A])&A.q[0x9]));(O)[11820]=F;else F=O[0X2e2c];end;end;end;return nil,F,J;end,FG=function(A)end,U=function(A,j,M,J,O)(J)[0xd]=(nil);j=88;repeat if j==88.0 then(J)[10]=A.NG;if not M[0X5Cb4]then j=(-0X17ffA9+(((A.q[0X5]<A.q[0X4]and A.q[0x4]or M[0X56b2])&j&M[12672])<<16));M[0X5cB4]=j;else j=(M[23732]);end;elseif j==0x1.5CP6 then J[11]=A.LG;O={};if not(not M[24707])then j=M[24707];else j=(-13+(((M[0X189E]&M[0X76dF])>>7<=M[0X56B2]and A.q[5]or A.q[0X5])~=A.q[0X02]and j or M[0X2765]));M[24707]=(j);end;elseif j==74.0 then j=A:X(J,M,j);else if j~=33.0 then else J[0XD]=(nil);break;end;end;until false;(J)[0xe]=(nil);return O,j;end,yI=function(A)end,qI=function(A,j,M,J)j[0X26]=(function(O,F,S)local X={j,j[0x6],j[27]};local j,T=O[0X005],O[0X3];local V,f,b,q,P,Y,U=O[0x9],O[0x8],O[0X2],O[6],O[0x7],O[11],(O[0X1]);S=(nil);S=function(...)local Z,N=1,X[0X1][15](j);local j,k=X[1][0X25](...);local _,e,t,Q,w,I,D,R=1,0x1,0;local G,g,W,i=X[0x1][7](function()while true do local c=(P[e]);if not(c<0X034)then if not(c<0x4E)then if c>=0X5B then if not(c<0X62)then if c>=0X65 then if not(c<103)then if c==104 then X[0x1][0XC][V[e]]=(N[Y[e]]);else local B,p,h=f[e],V[e],(Y[e]);if p==0X00 then else Z=B+p-0X1;end;local r,H;if p~=0X1 then r,H=X[0X1][0X25](N[B](X[1][0X2](N,B+1,Z)));else r,H=X[0X1][37](N[B]());end;if h~=0X1 then if h~=0X0 then r=(B+h-0x2);Z=(r+1);else r=(r+B-0x1);Z=(r);end;p=(0X0);for h=B,r do p=(p+0X1);(N)[h]=(H[p]);end;else Z=(B-1);end;end;else if c~=102 then N[V[e]]=nil;else N[V[e]][U[e]]=N[f[e]];end;end;else if c>=99 then if c==100 then if not(not(q[e]<=N[V[e]]))then else e=(Y[e]);end;else local B,p,h,r,H=32;while true do if B>0X1.2P3 and B<82.0 then p=0x46;B=(82+((c<<B)-c>>B>>B));elseif B<0x1.0P5 then r=(23);B=-15+((c&B|B)>>B>B and B or c);elseif B<0X1.5p6 and B>32.0 then H=P[e];B=0x9+(((c|B)&c)>>18>>31);elseif B>82.0 then H=(H>>r);break;end;end;r=P[e];H=H&r;B=(0X7C);while true do if B==0x1.FP6 then r=c;B=(-0xF838+((B<<0X9|B)+c-B));elseif B==0X1.58p5 then H=H>r;B=(-93+((c+c+B<B and c or c)|B));elseif B~=0x1.Cp3 then else if not(H)then else H=P[e];end;break;end;end;if not H then H=P[e];end;B=(0x68);while true do if B>0x1.38P5 and B<0x1.ap6 then r=(c);H=H<=r;break;elseif B<0X1.68p6 then H=(H-r);B=(51+(((c>=c and c or c)~c)+B|B));elseif B>0x1.68P6 then r=(c);B=0X2c+((B|c|B<c and B or c)-B);end;end;B=37;while true do if not(B>0X1.fp4)then H=H-r;break;else if B==37.0 then if not(H)then else H=(P[e]);end;B=-0x24fc0+((c-c<<0X1B>=c and c or B)<<0Xc);else if not H then H=P[e];end;r=(c);B=(-0Xc4+((c-B<B and c or c)+B|c));end;end;end;r=(c);H=(H<=r);B=(37);while true do if B>37.0 then if not(not H)then else H=(c);end;break;elseif B<0x1.0P6 then if H then H=c;end;B=(28+((c+c~B)-B&B));end;end;r=(c);B=(0X73);while true do if B==0X1.bp5 then p=p+H;break;else H=(H-r);B=-45+(((B~c)<<0Xc<=B and c or c)~=B and c or c);end;end;(P)[e]=p;B=(0x6e);while true do if B>110.0 then if not(B<=0X1.bcp6)then H=(f[e]);B=(197+(((c~c~B)>>0X15)-B));else h=(Y[e]);break;end;else if B>=110.0 then p=N;B=7+(((B&B)>>0X5>=B and c or B)|B);else r=N;B=(0Xc+(((B<<0X1a<=c and c or c)<c and B or c)>B and c or c));end;end;end;B=67;while true do if B<0x1.18P6 then r=(r[h]);B=(0X46+((((c<=c and B or c)==B and B or B)==B and B or B)-B));elseif B>0x1.0Cp6 then(p)[H]=(r);break;end;end;end;else local B=(false);D=D+Q;if Q<=0 then B=D>=R;else B=(D<=R);end;if B then N[f[e]+0X3]=(D);e=V[e];end;end;end;else if not(c<0X5E)then if c<0X60 then if c==95 then(N)[Y[e]]=Y;else(N)[V[e]]=X[1][0Xf](f[e]);end;else if c~=97 then local B,p,h=(63);while true do if B==0x1.f8P5 then p=P[e];h=(f[e]);B=-45+(((c<=c and f[e]or f[e])>=c and B or c)+B<c and f[e]or B);elseif B==18.0 then p=p<<h;break;end;end;h=f[e];p=(p+h);B=(124);while true do if B==0x1.fP6 then h=(P[e]);p=p+h;h=(P[e]);B=(-60+(((f[e]|c>=B and f[e]or f[e])>=f[e]and f[e]or B)+c));elseif B~=0x1.58p5 then else p=p|h;break;end;end;h=(f[e]);p=p<<h;B=(0X56);while true do if B==86.0 then h=P[e];B=(61+(((c~c)-B&B)>>f[e]));elseif B==61.0 then p=(p~h);break;end;end;h=(f[e]);local r=(-1585969);B=(0x6c);while true do if B<0x1.F8P6 and B>0X1.6cP6 then p=(p>>h);B=(91+((((c>c and c or B)>c and c or f[e])>c and B or c)>>f[e]));elseif B>108.0 then p=p<<h;break;elseif not(B<108.0)then else h=(f[e]);B=30+(((B+c>=B and B or B)>f[e]and f[e]or c)>c and f[e]or c);end;end;B=(0X5f);while true do if not(B<=0x1.Ap5)then if B==105.0 then r=(r[p]);B=-949+(((B>>f[e]<c and f[e]or f[e])<<f[e])+B);else r=r+p;B=(-0X2e+((B<<f[e])+c&f[e]>=c and B or c));end;else if B<=0X1.9p5 then P[e]=(r);r=N;p=f[e];B=(73+((B-B>>f[e]~B)&c));else r=(not r);if not(r)then else h=(nil);for B=67,144,77 do if B<0x1.2p7 then h=(Y[e]);elseif not(B>0X1.0Cp6)then else e=h;end;end;end;break;end;end;end;else(N)[f[e]]=N[Y[e]]<N[V[e]];end;end;else if c<0x5c then t=f[e];for B=0X1,t do N[B]=(k[B]);end;_=t+1;else if c==93 then N[f[e]]=(N[Y[e]]^N[V[e]]);else(N)[V[e]]=q[e]*N[Y[e]];end;end;end;end;else if not(c<0X54)then if not(c<87)then if not(c>=0x59)then if c~=88 then N[V[e]]=N[Y[e]]<=N[f[e]];else(N)[f[e]]=(N[V[e]][N[Y[e]]]);end;else if c~=90 then(N)[Y[e]]=F[V[e]][q[e]];else end;end;else if not(c<0X55)then if c~=86 then N[Y[e]]=(N[V[e]]>N[f[e]]);else(N)[Y[e]]=(N[V[e]]~q[e]);end;else if not(not(N[V[e]]<N[f[e]]))then else e=Y[e];end;end;end;else if not(c<81)then if not(c<0X52)then if c==0x53 then Z=(V[e]);N[Z]();Z=(Z-1);else(N)[f[e]]=(F[V[e]]);end;else if w then for B,p in X[1][1],w do if B>=0X1 then p[1]=p;p[2]=(N[B]);p[3]=(0X2);w[B]=(nil);end;end;end;return true,V[e],0;end;else if c>=79 then if c==0X50 then(N)[V[e]]=N[Y[e]]%N[f[e]];else if not N[f[e]]then e=Y[e];end;end;else local B=F[V[e]];B[0X1][B[3]]=U[e];end;end;end;end;elseif c<65 then if c>=58 then if c>=0X3d then if c>=0X3F then if c~=0X40 then local B,p=f[e],(j-t-1);if not(p<0X0)then else p=(-1);end;local h=(0X0);for r=B,B+p do N[r]=k[_+h];h=(h+0x01);end;Z=(B+p);else(N)[Y[e]]=N[f[e]]<<N[V[e]];end;else if c~=0x3e then if not(w)then else for B,p in X[1][1],w do if not(B>=1)then else(p)[0X1]=p;p[0x2]=N[B];(p)[3]=0X2;(w)[B]=(nil);end;end;end;return;else(N)[Y[e]]=(f);end;end;else if not(c>=0X3B)then if not(not(N[f[e]]<U[e]))then else e=(V[e]);end;else if c==60 then if N[Y[e]]==N[V[e]]then else e=f[e];end;else N[V[e]]=(N[f[e]]|N[Y[e]]);end;end;end;else if not(c<55)then if not(c<56)then if c==57 then(N)[V[e]]=(N[Y[e]]*N[f[e]]);else N[f[e]]=U[e]^N[V[e]];end;else N[V[e]]=not N[Y[e]];end;else if not(c>=0X35)then(N)[Y[e]]=N[f[e]]/N[V[e]];else if c==0X36 then N[Y[e]]=(N[f[e]]..N[V[e]]);else(N)[V[e]]=N[Y[e]]>>N[f[e]];end;end;end;end;else if not(c>=71)then if c<68 then if not(c>=66)then(N)[Y[e]]=#N[V[e]];else if c==0X43 then(N)[Y[e]]=N[f[e]]~N[V[e]];else if N[V[e]]==U[e]then else e=(f[e]);end;end;end;else if c<69 then e=(V[e]);else if c~=70 then local B=U[e];local p=B[0xa];local h=#p;local r=(h>0X0 and{});local H=X[1][38](B,r);(N)[f[e]]=H;if r then for E=1,h do B=(p[E]);H=(B[1]);local p=(B[3]);if H==0x0 then if not w then w={};end;local B=(w[p]);if not(not B)then else B={[3]=p,[1]=N};(w)[p]=(B);end;r[E-0X1]=B;elseif H~=0X1 then r[E-1]=(F[p]);else(r)[E-0X1]=(N[p]);end;end;end;else(N)[f[e]]=(N[Y[e]]);end;end;end;else if not(c>=0X4a)then if c>=0X48 then if c~=73 then local B,p,h,r,H,E=(0x001c);while true do if B<0x1.2CP6 and B>0X1.7p5 then p=(p-r);break;elseif B<53.0 and B>0x1.CP4 then r=(t);B=7+((c>>f[e]~=f[e]and f[e]or c)>>f[e]<=f[e]and B or c);elseif B<46.0 then h=(f[e]);B=-0X12+(((B|f[e])+c~B)-B);elseif B>0X1.A8P5 then p=j;B=(-104+(((B~c)+c~f[e])+c));end;end;B=0X46;while true do if B==70.0 then r=0X1;B=(0XD+((B>B and c or B)-c+f[e]<<f[e]));elseif B==109.0 then p=(p-r);break;end;end;local j;r=p;B=0X28;while true do if B>0x1.ap4 then if B~=103.0 then j=(0x0);B=-0X29+(((f[e]>>f[e]>=f[e]and c or c)|B)+B);else r=r<j;B=(-0X4d+((B&B~=B and B or B)<<f[e]>>f[e]));end;else if not(r)then else local t,L=(0x1f);while true do if t>41.0 then t=(0X29);L=-L;elseif t<0X1.C8p6 and t>0x1.FP4 then p=L;break;elseif t<41.0 then L=1;t=0X72;end;end;end;break;end;end;r=(0);j=(-9);B=(124);while true do if B<0x1.58P5 and B>14.0 then E=E~=H;break;elseif B>0x1.58p5 then E=(P[e]);H=(f[e]);B=(-0X110D1+((c<<f[e])-B<<f[e]|B));elseif B<0x1.5p4 then H=P[e];B=(21+(((f[e]<f[e]and B or c)&B)>>f[e]>>f[e]));elseif B<0X1.FP6 and B>21.0 then E=E&H;B=-189+(((B+f[e]>B and f[e]or c)<<f[e])+B);end;end;if not(E)then else E=P[e];end;if not(not E)then else E=c;end;H=(f[e]);E=E<H;B=32;while true do if B==32.0 then if not(E)then else E=(P[e]);end;B=(0x4a+(((B<f[e]and c or c)>>f[e])-c&c));elseif B==82.0 then if not E then E=P[e];end;H=(c);E=(E>=H);B=(0x9+((f[e]&f[e]&f[e])>>f[e]&B));elseif B==9.0 then if E then E=(f[e]);end;B=79+(((f[e]~c)&f[e])+B<B and f[e]or f[e]);elseif B==0x1.5P6 then if not E then E=P[e];end;B=(-0X4a+(((f[e]<B and c or f[e])~f[e]~B)+B));elseif B==35.0 then H=(c);break;end;end;E=(E&H);H=P[e];E=(E-H);B=102;while true do if B~=13.0 then H=(P[e]);B=(-576460752303423470+((B&f[e])-c-c>>f[e]));else E=(E~=H);if E then E=(f[e]);end;if not E then E=c;end;H=c;break;end;end;E=(E>H);B=121;while true do if B>19.0 then if E then E=P[e];end;B=-73+((f[e]&f[e])+B&c|f[e]);elseif B<0x1.E4p6 and B>0x1.0p2 then j=j+E;break;elseif B<0x1.3p4 then if not E then E=(P[e]);end;B=19+((B~f[e]|f[e]~=B and B or f[e])~B);end;end;P[e]=j;B=(52);while true do if B==52.0 then j=(h);B=0X36+(((B>>f[e]>=f[e]and f[e]or B)>>f[e])-B);elseif B==3.0 then E=h;H=p;B=0x3+((f[e]|c<=f[e]and c or c)<<B<=f[e]and f[e]or B);elseif B==0x1.8P2 then E=E+H;B=0X2D+((f[e]+B&f[e]<=f[e]and f[e]or c)>>f[e]);elseif B~=45.0 then else H=1;for t=j,E,H do local B,H,L,z=(0X50);while true do if B==80.0 then H=N;L=(t);B=0x6f;elseif B==0x1.Bcp6 then z=k;break;end;end;t=(nil);local l;B=107;while true do if B>78.0 and B<0x1.ACP6 then t=t+l;break;elseif B<0X1.54p6 then l=(r);B=85;elseif B>85.0 then B=78;t=_;end;end;z=z[t];(H)[L]=z;H=(r);for t=0XA,0XB6,86 do if not(t<=0x1.4P3)then if t<=0X1.8p6 then H=H+L;else r=(H);end;else L=(0X01);end;end;end;break;end;end;j=h;E=p;j=j+E;Z=j;else I={[0X2]=I,[5]=D,[0X4]=R,[0x1]=Q};local j=Y[e];Q=N[j+2]+0;R=(N[j+0x1]+0);D=N[j]-Q;e=(f[e]);end;else local j=f[e];(N)[j]=N[j](N[j+1]);Z=j;end;else if c<76 then if c==0X4b then local j=f[e];N[j]=N[j](X[1][2](N,j+1,Z));Z=j;else local j=(Y[e]);local t,B=D(R,Q);if not(t)then else(N)[j+0X1]=(t);(N)[j+0X2]=B;e=(V[e]);Q=t;end;end;else if c~=0X04D then local j=(F[f[e]]);N[Y[e]]=j[0X1][j[0x3]];else local j=(F[V[e]]);N[f[e]]=(j[0x1][j[3]][U[e]]);end;end;end;end;end;else if not(c>=26)then if c>=13 then if not(c>=0x13)then if c<0X10 then if c<0xE then N[V[e]]=X[0X1][12][f[e]];else if c==0XF then I=({[2]=I,[5]=D,[0X4]=R,[0x1]=Q});Z=f[e];D=(N[Z]);R=N[Z+1];Q=(N[Z+2]);e=V[e];else(N)[Y[e]]=(k[_]);end;end;else if c>=0X11 then if c~=0X12 then(N)[V[e]]=N[Y[e]]>=N[f[e]];else Z=Y[e];(N)[Z]=N[Z]();end;else N[V[e]]=N[Y[e]]==q[e];end;end;else if not(c>=22)then if not(c>=0x14)then N[Y[e]]=(-N[V[e]]);else if c~=0x15 then for j=0X1,Y[e]do(N)[j]=k[j];end;else if w then for j,k in X[1][0X1],w do if j>=0X1 then(k)[0X1]=k;k[2]=N[j];k[0x3]=0X2;(w)[j]=(nil);end;end;end;local j=Y[e];Z=(j+0X1);return true,j,0X2;end;end;else if c<24 then if c==0X17 then(N)[Y[e]]=(N[f[e]]/b[e]);else if N[f[e]]then e=(V[e]);end;end;else if c~=25 then(N)[f[e]]=(N[Y[e]]*b[e]);else if w then for j,k in X[1][0X1],w do if j>=1 then k[1]=(k);(k)[2]=(N[j]);(k)[0X3]=(0X2);w[j]=nil;end;end;end;return true,V[e],0X1;end;end;end;end;else if c>=6 then if not(c<9)then if not(c>=0Xb)then if c==10 then local j=V[e];N[j]=N[j](N[j+1],N[j+2]);Z=j;else if not(w)then else for j,k in X[1][0X1],w do if j>=0X1 then(k)[1]=k;(k)[0X2]=(N[j]);k[3]=(0X2);(w)[j]=(nil);end;end;end;local j=f[e];return false,j,j+V[e]-0X2;end;else if c==12 then for j=f[e],Y[e]do N[j]=nil;end;else N[V[e]]=N[Y[e]][q[e]];end;end;else if c>=7 then if c==8 then(N)[f[e]]=(N[V[e]]+N[Y[e]]);else N[Y[e]]=N[V[e]]-q[e];end;else local j=Y[e];Z=j+f[e]-0X1;N[j](X[0X1][0X2](N,j+0X1,Z));Z=j-0x1;end;end;else if not(c<0x3)then if c>=0x4 then if c==5 then if not(w)then else for j,k in X[1][1],w do if not(j>=1)then else k[0X1]=k;k[0X2]=N[j];(k)[3]=(0X2);w[j]=(nil);end;end;end;local j=Y[e];return false,j,j;else(N)[V[e]]=N[Y[e]]%q[e];end;else N[Y[e]]=N[V[e]]&N[f[e]];end;else if not(c<1)then if c~=2 then(N)[Y[e]]=(q[e]+N[V[e]]);else(N)[V[e]]=(N[f[e]]>>U[e]);end;else(N)[V[e]]=N;end;end;end;end;else if c<0X27 then if not(c<32)then if c>=35 then if c<0X25 then if c==0X24 then N[Y[e]]=P;else if not(w)then else for j,k in X[0x01][1],w do if j>=0X1 then(k)[0x1]=(k);(k)[0X2]=(N[j]);k[0X3]=(2);w[j]=(nil);end;end;end;return false,f[e],Z;end;else if c==38 then local j=Y[e];Z=j+f[e]-1;N[j]=N[j](X[1][2](N,j+1,Z));Z=(j);else local j=f[e];N[j](N[j+0X1],N[j+2]);Z=j-0X1;end;end;else if not(c>=33)then local j=f[e];N[j](N[j+0x1]);Z=j-0X1;else if c~=34 then(N[f[e]])[N[V[e]]]=(N[Y[e]]);else N[Y[e]]=V;end;end;end;else if c>=29 then if c<30 then(N)[Y[e]]=N[f[e]]+b[e];else if c~=31 then local j=(F[f[e]]);(j[0X1])[j[0X3]]=N[V[e]];else(N)[Y[e]]=(O);end;end;else if c>=27 then if c==0X1c then N[Y[e]][b[e]]=(q[e]);else local j,O=Y[e],N[f[e]];N[j+0x1]=O;(N)[j]=(O[b[e]]);end;else local j=V[e];local O=(N[j]);local q=Y[e];X[0X1][18](N,j+0X1,Z,q+0X1,O);end;end;end;else if c>=45 then if not(c<48)then if not(c<50)then if c~=51 then(N)[Y[e]]=N[f[e]]&b[e];else local j=(f[e]);(N[j])(X[1][2](N,j+1,Z));Z=j-0x1;end;else if c==49 then local j=(F[f[e]]);N[V[e]]=j[1][j[0x3]][N[Y[e]]];else if N[V[e]]==N[f[e]]then e=(Y[e]);end;end;end;else if c>=0X2e then if c==47 then local j=(F[f[e]]);j[1][j[3]][b[e]]=(N[Y[e]]);else N[f[e]]={};end;else if not(not(b[e]<N[Y[e]]))then else e=(f[e]);end;end;end;else if not(c>=0X2a)then if c<40 then(N)[V[e]]=(N[Y[e]]-N[f[e]]);else if c==0X29 then N[f[e]]=(F[Y[e]][N[V[e]]]);else N[V[e]]=(U[e]);end;end;else if c<43 then D=(I[0X5]);R=I[0X4];Q=(I[1]);I=(I[0X2]);else if c~=0X2c then local j,O,b,q=59;while true do if j>0x1.d8P5 then if not(j>=94.0)then b=(b>>q);break;else b=P[e];j=(-0x39+((j<<0X19<=j and c or j)~c>=j and j or c));end;else if j==0X1.28p5 then q=(25);j=21+((c<<0X8)+c>>0X13~c);else O=(-24);j=0X5e+((c+j~c|c)>>31);end;end;end;q=(c);b=(b|q);j=0x53;while true do if not(j<=0X1.6P4)then if j~=0X1.4cP6 then q=P[e];break;else q=(c);j=(0X16+((c-j~j<c and c or j)>>14));end;else b=(b|q);j=-92274563+((c-c|c<=c and j or j)<<j);end;end;b=b+q;j=0X2d;while true do if j<45.0 then if b then b=P[e];end;break;elseif j>40.0 then q=c;b=(b>=q);j=(-0X3+(((j>>0X6)-j>=c and j or c)>=c and c or j));end;end;j=(0X4A);while true do if j<74.0 and j>12.0 then q=P[e];j=(-21+((j+j+j<=j and j or j)&c));elseif j>33.0 and j<123.0 then if not b then b=P[e];end;j=-0x29+(c-c+j&j|j);elseif j>0X1.28p6 then if b then b=(P[e]);end;break;elseif j<0x1.08P5 then b=b>q;j=(123+((j~j)<<j<<j<<j));end;end;if not(not b)then else b=(c);end;j=0X57;while true do if j>74.0 then q=P[e];j=74+(((j|j)~j)>>(X[0X1][0XC][0X6]('\z  \62i\z  8',"\0\z\u{00}\0\0\0\0\0\a"))&j);elseif j<87.0 and j>33.0 then b=(b<=q);if not(b)then else b=(c);end;j=-8796093022131+(c-j<<13>>21~c);elseif j<0X1.28p6 then if not(not b)then else b=(P[e]);end;break;end;end;j=(0x6e);while true do if j<110.0 and j>0x1.0P1 then O=(O+b);j=154+(j-c-j+c-c);elseif j<0X1.4P6 then O=(N);break;elseif j<117.0 and j>110.0 then(P)[e]=(O);j=-0X29+((j~j>=c and j or j)>>0xa~c);elseif j<111.0 and j>80.0 then q=P[e];j=(0X8E+(((c<j and j or j)&c)+c-j));elseif not(j>0X1.bCP6)then else b=(b+q);j=37+((j&j==c and c or j)+j>=j and c or c);end;end;j=(0X5c);while true do if j<92.0 then q=(f);(O)[b]=q;break;elseif j>11.0 then b=(Y[e]);j=((j~c)&j<=j and j or c)>>(X[1][0Xc][0X6]("<i\x38","\3\z\0\0\z \0\0\0\0\0"));end;end;else local j=F[f[e]];(j[0X1][j[3]])[N[V[e]]]=N[Y[e]];end;end;end;end;end;end;end;e=e+1;end;end);if not(G)then if not(w)then else for j,O in X[1][0X1],w do if not(j>=1)then else(O)[1]=O;O[2]=N[j];(O)[0X3]=0X2;(w)[j]=(nil);end;end;end;if X[1][0x3](g)~='s\u{0074}\114\x69n\103'then(X[0X3])(g,0);else if not(X[0x2](g,'\x3A\40\37d+)\z \91\z  :\r\10\x5D'))then(X[3])(g,0);else(X[0X3])("L\z \x75ra\zp\z\x68 S\x63\z \x72\zip\u{074}:"..(T[e]or'(in\z  te\z\114\u{006E}a\u{006C})').."\u{3A} "..X[1][9](g),0X0);end;end;else if g then if i==0x1 then return N[W]();else return N[W](X[1][2](N,W+1,Z));end;else if not(W)then else return X[1][2](N,W,i);end;end;end;end;return S;end);if not(not M[0X1C77])then J=A:n(M,J);else J=A:o(J,M);end;return J;end,QG=function(A,A,j)j[1][24]=A;end,z=function(A,A)local j,M=A[1][0X011]("<\x494",A[1][0X14],A[0X1][0X10]);(A[0x1])[16]=(M);return{j};end,NG=string.pack,F=function(A,j)(j)[22]=select;(j)[0X17]=A.c;end,K=table.unpack,C=function(A,j,M,J)j=nil;M=nil;J=(nil);for O=0X9,0XE0,46 do if O>0x1.B8p5 then J=0X23;break;elseif O<0X1.B8p5 then j=A:x(j);else if O<101.0 and O>9.0 then M=0;end;end;end;return j,J,M;end,S=function(A)end,Q="\x5F\u{005F}\x6Ee\119i\110\100ex",wG=function(A,A,j)A[0x4]=j[0X1][0X22]();return{A};end,gG=function(A,j,M,J,O,F)for S=0X1,J do local J,X;J,X=A:BG(J,X);goto O;::A::;A:RG(F,j,J,S);goto F;::j::;A:rG();goto A;::M::;A:AG();goto j;::J::;X,J=A:VG(X,j,J);goto M;::O::;J=A:WG(J);goto J;::F::;end;O=nil;M=(nil);return O,M;end,AI=function(A)end,y=function(A,A,j)(A[0X1])[0X10]=A[0x1][0X10]+1;do return{j};end;return nil;end,WG=function(A,A)A=(nil);return A;end,FI=function(A,j,M,J,O)if j&1~=0 then M=A:fI(O,j,J,M);else(J)[M]=j>>1;end;return M;end,VG=function(A,j,M,J)j=M[2]();if not(j<=27.0)then A:EG();goto X;::S::;A:XG();goto T;::X::;J=A:UG(j,J,M);goto S;::T::;else if j~=27.0 then J=M[1][33]();else J=M[0x002]()==0X1;end;end;return j,J;end,A=function(A,j,M,J,O)J[4]=A.CG;J[0X5]={};(J)[0X6]=(A.s.match);J[0X007]=(nil);J[0X8]=(nil);J[9]=(nil);O=(117);repeat if O==117.0 then J[0X7]=pcall;if not M[0X56b2]then O=(-2661112248+((M[0X189e]&A.q[0X4])-M[0X2765]<<20<A.q[9]and A.q[2]or A.q[0x8]));(M)[22194]=(O);else O=(M[0X56B2]);end;else if O==80.0 then(J)[0X8]=A.t;if not M[0X4669]then O=(-36+(((A.q[6]>>0Xd~=A.q[0x3]and O or M[22194])>>1)+M[30431]));M[18025]=O;else O=M[0X4669];end;else if O~=111.0 then else J[0X9]=tostring;break;end;end;end;until false;(J)[10]=(nil);(J)[0X0B]=(nil);j=(nil);J[12]=nil;return j,O;end,NI=function(A,A,j,M)(M)[A]=A-j;end,xG=string.unpack,qG=function(A,A,j,M,J)J[0X1][0X17][M+2]=A;j=0X27;return j;end,MI=function(A,A,j,M)(M)[j+0X2]=(A);(M)[j+0X3]=6;end,JI=function(A,A,j,M,J)j=A[0X1][13][M];J=#j;return j,J;end,GI=function(A)end,uI=function(A,A,j,M)j[A]=(A-M);end,pI=function(A,A,j,M)M=(#A);A[M+1]=j;return M;end,Y=function(A,A)A=(nil);return A;end,B=function(A,A,j)j=A[6302];return j;end,RI=function(A,j,M,J,O,F,S)local X=O[1][34]();j=0X1;F=(nil);local T;J=(nil);S=(61);repeat if S>0X1.E8p5 and S<119.0 then J=(O[0x1][0X22]()-80163);break;else if S>0x1.A8p6 and S<120.0 then for V=0x1,X,0X1 do local f=O[0X1][34]();if not(O[0X1][0X0019][f])then local b;b=A:tI(b);goto f;::V::;b=A:wI(f,b);goto P;::f::;A:cI();goto Y;::b::;A:GI();goto V;::q::;A:QI(b,V,T);goto U;::P::;A:KI(f,b,O);goto q;::Y::;A:BI();goto b;::U::;else(T)[V]=O[1][25][f];end;end;S=(106);elseif S>0x1.dCP6 then(M)[10]=T;S=0x77;else if S<106.0 then F=({});S=120;T=O[1][0x00f](X);end;end;end;until false;return F,S,j,J;end,l=function(...)(...)[...]=nil;end,lI=function(A,A)A=nil;return A;end,cI=function(A)end,D=function(A,j,M)local J=A.w;for A=0,0XFF do M[A]=J(A);end;j[0x14]=nil;j[0X15]=(nil);j[22]=nil;j[23]=nil;end,dI=function(A,A,j,M)A=100;M=#j;return A,M;end,oI=function(A,A,j,M)M=(A[0X1][0XD][j]);return M;end,h=function(A,A,j)do return{j[1][11](j[1][20],j[1][16]-A,j[1][16]-1)};end;return nil;end,fG=function(A)end,f=function(A,j,M,J)j[0X15]=function(O)local F,S={j},0X03c;repeat if not(S>60.0)then S=A:I(S,F,O);else(F[0X1])[16]=(0X1);break;end;until false;end;if not(not M[27758])then J=(M[0X6C6e]);else J=(0X6C+((A.q[0X1]-M[30431]~A.q[0X4]<M[6302]and J or A.q[2])>>M[0X508B]));(M)[27758]=(J);end;return J;end,LI=function(A,A,j,M,J)local O,F=36;repeat if O==0X1.2P5 then O=(51);F=#j[0x1][0X17];elseif O==0x1.98p5 then if j[0X1][9]~=j[1][0X1C]then(j[1][0X17])[F+1]=(A);end;O=(0X76);else if O==118.0 then j[1][0X17][F+0X2]=(J);O=93;else if O==93.0 then j[0x1][23][F+3]=(M);break;end;end;end;until false;end,d=function(A,A)A=nil;return A;end,fI=function(A,A,j,M,J)J=A[1][29]();local O=A[0X1][29]();for A=j>>1,J do(M)[A]=(O);end;return J;end,o=function(A,j,M)j=(0x26+((((M[24707]==A.q[0X4]and M[0X5F78]or M[24440])==M[22194]and M[0X2765]or A.q[0X4])==M[0X7331]and M[10085]or A.q[2])>>M[18237]));M[0X001c77]=(j);return j;end,UG=function(A,A,j,M)if not(A<=160.0)then j=M[0X1][0x24]();else j=M[0X1][31]();end;return j;end,g=function(A,j,M,J)(M)[18]=nil;M[0X13]=nil;J=(0X65);while true do if J<0x1.7Cp6 then(M)[18]=A.dG;if not(not j[29489])then J=j[0x7331];else J=(0x23+(((A.q[0X3]>>j[0X4128])-j[0x73aD]>j[12672]and j[0X3180]or A.q[0x6])>>J));j[29489]=(J);end;else if J<0X1.94p6 and J>0.0 then(M)[0x13]=A.kG;break;else if not(J>0x1.7CP6)then else M[0X11]=(A.s.unpack);if not(not j[16680])then J=(j[0X4128]);else(j)[12903]=(-0X00FFce+((((j[0Xc06]==A.q[0x9]and j[0x76DF]or A.q[0X8])|j[0X73Ad])~A.q[0X08])<<15));j[0XC9a]=(39+((A.q[4]~j[0x73Ad])>>30|A.q[3]~=j[0X6083]and j[6302]or A.q[0X4]));J=(-308673065+(((A.q[0X2]|j[18025])~A.q[8]|j[24707])>>3));(j)[0x4128]=(J);end;end;end;end;end;return J;end,hI=function(A,j,M,J,O,F,S)if not(O<=0x1.8P2)then A:bI(j,F,M,J,S);return 47952,j;else j=#J[1][23];end;return nil,j;end,KG=function(A,A,j,M)(M[0x1])[0X00d]=M[0x1][0xF](A);j=(M[2]()~=0);return j;end,lG=function(A,A,j,M)(j[0X1][0X17])[M+3]=(A);end,aI=function(A,j,M,J,O,F,S,X,T,V,f,b,q,P,Y,U,Z,N)local k,_=(F>>0X3);q=(nil);for e=24,0x7E,0X3 do if e>24.0 then if q==b[0X1][3]then _=A:zI();return{A.K(_)},q;end;break;else if e<27.0 then q=A:mI(Y,q);end;end;end;if N==b[0x1][0X3]then return{b[1][11]},q;end;for e=62,0Xfa,0x2F do if e==203 then if V==1 then if not(b[1][0X18])then J[U]=b[1][0X0d][M];else local t,Q;t,Q=A:iI(t,Q);goto N;::Z::;t,Q=A:JI(b,t,M,Q);goto k;::N::;A:xI();goto Z;::k::;(t)[Q+0X1]=j;(t)[Q+2]=(U);(t)[Q+3]=0X1;end;elseif V==0X4 then Z[U]=(M);else if V==6 then A:CI(Z,M,U);elseif V==0X5 then A:NI(U,M,Z);else if V==0X03 then A:LI(J,b,M,U);end;end;end;elseif e==0Xfa then if T==1 then if not(b[0X1][24])then(X)[U]=(b[1][0XD][k]);else N,F=nil;N,F=A:kI(F,k,N,b,j);A:MI(U,F,N);end;else if T==4 then A:OI(S,k,U);elseif T==0X6 then A:jI(U,k,S);else if T==0X05 then A:uI(U,S,k);else if T==0X3 then Y=nil;for j=6,0X8b,0X6b do _,Y=A:hI(Y,X,b,j,k,U);if _~=47952 then else break;end;end;end;end;end;end;elseif e==0x009C then(Z)[U]=(M);(O)[U]=(q);else if e==0X3e then f[U]=(P);else if e~=0X006d then else(S)[U]=(k);end;end;end;end;return nil,q;end,kG=setmetatable,W=function(A,j,M,J)(M)[15]=nil;J=(15);while true do if J==0x1.EP3 then M[14]=function(...)local O=({M});if O[1][0XB]==O[0X1][0Xc]then return O[0X1][0Xc];end;return(...)[...];end;if not j[0x73Ad]then J=27+(((A.q[7]~A.q[8])&A.q[5]|J)&j[0X189E]);j[0X73Ad]=(J);else J=A:V(J,j);end;else if J~=34.0 then else M[15]=(function(A)local j={M};return{j[0X1][2](j[0X1][5],0x1,A)};end);break;end;end;end;(M)[0X10]=(1);M[0X11]=nil;return J;end,T=function(A,j,M,J)j=(0X43);while true do if not(j>67.0)then M[20]=(function(O)local F=({M[4],M});O=F[1](O,'z',"!\z!!!\z!");return F[0X1](O,"..\46\46.",F[2][19]({},{__index=function(O,S)local X,T,V,f,b=F[2][0X8](S,1,0X5);local q=((b-0X21)+(f-33)*85+(V-0X0021)*7225+(T-0X21)*614125+(X-33)*0X31C84B1);T=F[2][10]("\62\0734",q);O[S]=T;return T;end}));end)(M[0xB]([=[LPH@lSegX!E-W4<M6Goz!!&\%EU$s4!!!"lP5tXaz^'8(cDI[*s^&_<L!GA)*z!!!#5!I)6^@<6L$Ecdr\!!'c5/F<DN!ICD(Uu;@T!!!#5!HatBz!!!#5"E\p.A\J1R^&_o]"^bVFA7WCT=M=hh5G/Sgz!!'_:?XIks@_VIL$6UH6+<VdL+>#0L>7(][+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL/jL^20.JM*/hSb//hS7h+<VdL/hSb-/1N;$,:+[%5V<Bd+<VdL+<VdL+<VdL+<VdL+<VdL-n6>^+=o/o,:+W_-9sg]5UId*-nd5,0.84s,9nKZ,9nTb0.JG&/1r%f+<VdX0/"_#/d`^D+<VdL+<VdL+<VdL+<VdL+>52e/gWbJ5X7S"5X6VH+<W9b-9sg]-71&d-71uC5X7S"-6jog/1rP-/hSb//h//45X6_M+<W3[/d`^D+<VdL+<VdL+<VdL+<VdV0-Dko5X7S"5X7Ra+<W'Y/0H&X.OZVj5X7S"5UId*.P*1p+<VdL+<VdL+<VdL/hAJ#,:+`f5X6YG+<W-b$6UH6+<VdL+<VdL+<VdL+<rE[00hcf5X7Ra+=\]d+=nid0.ne/,:+Z`5X7R]-mh2E5X7S"5X7S"5X6PD/1rP-/hS\.-9sg]5X7S"5U[a-,mkb;+<VdL+<VdL+<VdL+<r!O,="LZ5X6eP5U@O*,:+rq-nHu%0.JM+0.JM*/2&D$5X7S"5X7S"5X7S",sX^\5X7S"5X6PH,="LZ5X7R]/g)GI+<VdL+<VdL+<VdL+<W<[+=9?=5X7S"5X6_D5U.C$-712h5X7S",;1B/5X7Rf,pb/p,sX^\5X7S",qhMK-7CDf+=o&p/hSb!+=\[&5X6P:.LI:@+<VdL+<VdL+<VmO+>,!+5X7S"5X7S"5X6kK-m_,D5X7RZ/g)8Z+=nj)5U/NZ-7U,j-9sg]5X6YI/gEVH5X6tL5X6VD5X7R]-nd,"-7g8m/.*LB+<VdL+<VdT0-DA[-pT++-7(!(5X6YL/0HK/,:GfB5X6kC+<VdL+<VdO5X6tR-9rn#00hcf5X6kH,:,T?5X7R_+<VdL+=]WA5X7R]/0uSp+>+!D+<VdL+<Vd[+<Vm^/0dDF5UI^(0/"P85X6tF,sX^\-9sg]-nZVb+<W3^5X6_M.PE7o+=09<.NfiV,sX^\5X7R\+<VdL+<VdT5X6YE.P<>+,pk5O+<VdL+<VdL+>5B$5X6YI+<W'Z5X6PF+<Vd[5VF62.OIDG5X6P@5X6V?,q(/f5UIs'00hcf5X7R]/g)B(5X6P@5X7R],pbfA5X7S"-7geu.R5X3$6UH6+<VdL+=/<d-9rdu/g`hK5U.C)5X7S",pklB5UJ-:+<VdX0.85%.P)\b/h\P:5X7S"5X7S"5V+B3-n[/!5X6PD-9sg]-mL,m/hSb--6k!*0+&gE+<VdL+<Woq/g_nf/g`hK5UIs'+<Vd[-9sg]5X7S"5X7S"5X7S"5UJ`],;1Gk5X7S"5X7S"5X6YI+<W't5X7S"5X7S"5X7Rf/3lHc5X6PH-7T?F+<VdL+<VdR-7gGh+>+uj+<VdL00hcf-nZVb/1<bK5X7R]0.8J,0/"Ou+>5',5X7S"5X7S"5X7S"5X6_?+=nj)5X7S"5X7R]/0H?+5UIs65U\8m+<VdL+<VdL/gVtl5U[a.5X7S"-m1!)5X7S"5VF6&+<VdV,sX^\5X7S"-8$i7-6Oia/0HPl5X7S"5X6P:/gDhl-8-np5X7S".NfiV.R66G0.J:u$6UH6+<VdL+<W9`0.nJ75X7S"5X6kC+<W-\5X6VJ/1*VI-7CDf+<VdX-m_,)-9sg]5X7S"5X6_M.P)\b00hcf5X7S"5X6YI+<VdL+<Vsq5X7Re/d`^D+<VdL+<Wp!+>+s*5X7S"5X7R_+<VdL+<VdZ+<VdT5X7S"5X7S"-m0WT+<VdL/h/7q-9sg]5X7S"5X7S"5UIm1+<W9i/h0+4+<Vd[5X6V</h[PS+<VdL+<VdL+@%D!/g`hK5X7S"-8$D`+<VdL+<VdL+<VdZ0.&qL5UnB55X7S"5X7R]/0HJn.P*1p+<VdZ/1N%p-nZf25U.Bt5Umm!/3lHH+=n`E+<VdL+<VdL+<VdL-7g8m5X7S"5X6eA+<VdL+<VdL+<VdL+<VdL+<VdZ,="LZ5X7S"5UnB45X7S"5U\0K5X7S"5UIU),q(Ag+<VdL+>,!+,p4``$6UH6+<VdL+<VdL+<Vd[+=]WA5X7RZ+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdQ5UJ*7,75P9+<VdL+<VdL+<VdL-n$2j-9sg]5Umm!+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL,=!S./0bKE+<VdL+<VdL+<VdL+<W9`/g)\l5X7Rc+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+=KK%/hA4S+<VdL+<VdL+<VdL+<VdL+<Vm]+>+s*5Umm05X6tF+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<W=&-8$ht$6UH6+<VdL+<VdL+<VdL+<VdL+>,;i+<s,t/g)H*-7g\m/0H&X+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd[5X6kQ0+&gE+<VdL+<VdL+<VdL+<VdL+<VdL.OZD^,=!P-+>+cb5X7S"5UA'7+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL00hcR/h.2N+<VdL+<VdL+<VdL+<VdL+<VdL+<Vd[0-DA`5UJ$).R66a5X7S"5U[a'5UA'9+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<s-:/0H>J+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VmY+>,!+5U.m(-pU$_5UJ*55X7S"5X7S",q^;i0.n@i+<VdL+<VdL+<VdL+<VdL.P<>".P<&55V+$2$6UH6+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+@%D!/gWbJ5U@s(/2&+u5X7S"5X7S"5X6kQ,sX^\5X6V</g`hK5Umm$5UJ*9-9s%3.Ng$&5UJ*+.LI:@+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+>4i[.OIDG5X6VH+<VdV-mh2E5X6YK+<s-:5X7Ra+<s-:5U@O$5X6eA/1r%f+>5uF5X6eA-jh(>+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<Vdl,;()k,="LZ5X7R]-nHtn+<VdL+<VdL+<VdL+<VdL+<VdL+>,2p-m^3*5X7S"-8$o!$6UH6+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<W!Z/g)8Z/h\M95X7S"5X7S"5X7S"5X7S"5X7S"5X7S"5X7S"5X7S"5U\6--n#EF+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+<VdL+=n`j.P;hd+<VdL+>,8t/1`>'/1`>)/hSb!+<VdL+<VdL+=o/j$47mu+<VdL+<Xrq/M.;:+<VdL+<VdL^&^p##64`(z^&_%6!!'h7s8UtB"TSN&z!58J:^&_3+!!*'"z^'.kND09Zf5RBq6z^&_`X!D:',DnZ6a^&_u_!CWTIz!!!"lY#?LSz^&_0H$X[7XATV@&@:F%a^&^m@!Ca^'A\J/Y!Ci_U^u[EQs8W*&z!!)LQ^&`#`!E#Kjz!!!#5!C=F#EhER9z!!&[hz!!!#5"*.sl^'nXcFDYT2@<>peCh:<]BtajpDf^#@Bl7Rt!DU9/E4uO$E+<<mCq]s_2nfK1DKBB0FJ-UD*.\(i!!'_<@W-1$ARTJj!c0fg`rH)>z"TSN&!!!!Q6(enlz!!&ZIz!!!#5"`7[i@q`RW6G<J(^&i=6THF47z!58eI?Z^4-FE2)5B>+CU^&`,c$T][^A1K*53XlF%^'%qZ@<*:f^'/Ue@VfVi#[^qKDf0&nFM7cdTE5)nz!58\F?YOCgAU(onF`)/,@r&d]DIn'7^&_!C#Qau+z!2,VXz!!'_6<k\T1^&^`s#QOi)z^'8Y#EbTE(^&_T6"98E%z^'GGRz!!'_66bWRGT`>&lrr<$!!2';lz!!&Yrz!!!#5!Hu0Y=#[hr@X3',^&`&a"$C9W^'/Ic@;Kbo!D'p*FeAg:z!!&Yuz!!!"l)#sX:zTFG]MB`J,4s1SMZ^&]@j!I2<_Eaa05ATXUFs8W-!s8W,5"CGMPA\J:[F*1rb5QCcaz^'%eMAT=CC!rr<$!!!#5#'>-0AT)1p"*8ToTE"rl!<<*"!58MK2nfH&?Y!ko^'.kND/Wt!"^bVUDg/nrF1qZH^'&C`@r%_Zz!!!"l'`\46z^'&:]FD/AmDKTf*ATGKc0tmj(DfT]'F;k4o#'+-rB4Z2!#%qd]FCT!Wrs&N(z^'%eMCimAqF(K0!@s#EcD8$3]?XmM\C]se=z0LNP_F(KH1ATV@&@:F%aTF_)'z!58JR"TSN&!!!#g5m75gz*'h4@Anc-n^'\4SDIn$+DId='TE"rmz!1E$O#Qn04Pl\Dc"9JXR6imF56lH+N0e1QO$<\h[)Ctq>&lJc4#"0Xj!_*5@![&+*$<R?2#"0pB!X6^dRK9E/9`bA16imE6AKh0W"VLk<'FNe')@I/r)H\j8!`&k!777+U!!!!Q#m(59%1s`u)'.W-"9JYe)+4N-hAJ`P!<TtD8cf(^!CR"[!Tk#(!WqKe6is@iSc`F'!_,T+!Wo5'8cf(6!CZbbd02"&!WpXN7%s^n!Wki3_?'d.!WpLGAHKFEXpP[@!WjiMWWE5j!jVk//dfDs\cN6I_?'d-_?."E\cO#V!aS2$d/eh#$_@r^!r;pO!Wj]:g&_$N!_2GUJcZ!C!r;p!7fi`T6imGP"[r1fYm2a]!Wqck6imGX#=JUp!\+6QL(Qhj!MTVs7KNXc!`K.%h@W/m!V-6m7KNY^!E0%$p'O1hq>o^d('4Q_"[o'cdK0J>ao^8u!_*4miW<ZmdK2fI!WiEQ$IJmc!XlR@!YT/J!X;%"d/gf[$b?B@)JGiG\cMq&dK.2d!_*4maoZ,U\cUFn&'=s)#+>To1=?4*7[aD4!Wkgm!X;$odK0J?dK3%`![4!6)9N"cao]]e_#te$!f7!$!X-XIRK<O[!Wk2Hq>n,3.TlfSm/]T^JHV,;$N^B]!Xec)q>l0L5l(Liq>gTu!X;''!s4&U..RD)!Wkq#6%T.GJc^N*.Thf<!f@%-!WlXq!WiEQ\H;p(!@[dF\HaTe\H2O-q>gX!!X;&E!jMt[=o&0q!J1A?Jc`Ib.TuTKJcbcL"+gU%""IIM!J1CL!EVJ]!<Q$u!`VS)!MTVs7KNXc!`K.%^&g\(!Wjk&!SIT:A-)h(%n$Kq!Q>'T!Wr9#6j!2c`X`gd!ko46q>ludq>gW-!s4&U..RDQ"9M/X&Fpg0'13,S!TF.giW@7(g&`E!!^oEXncA^q@KHV>#XnY#Oob\\!Wo/!6imG8!CW(Ol2^rUiW8TN!_*7V!<PauT`Xcc$gIba!qH@S!Wn)W7)Auq!<P^l!qH@j!Wr'&6k\2S!_*Om!oa4g$IK+D!=Jr1#"0B`!?,SPg&]J(('4Pt"[r1fd/tk$!Wn)\7/?qp""IFT!r`3g`;tPl!`&k!Q4HC[!<V6]6.#i3!JUV9!Wnr+6iuo[.T5g<!qH@Xq>ntI.Tq?)f`<R*JcbcLq>gj'!X;&E!kALb=o&/N!r;pFJc`If.TuTKJcbcL<L![_!<Q$u!kn\'!g3U?;??o_!`K.%[K/eM!<ULI8cf(]"%31l!\3I9nc>0[=9A$oc3tHi!Z"3#!P&Ca=TSZd"%;)P!qH@?!Wo5-7+*07(oeK$!r;qO";V%?4[cgaK`glH637387$7TA!<PaU!Vufu7KW,]!_3:n2+.KIe,_u6!P&Ca=TSZd"@N=^!S%3[!Wn)W7(NF$eceYI!e^YDJcb0@.Tq?)q>pEn4+[Oe!@h4R![^>3!J1CL!<[oT\H=<aq>l0Lq>hrF!_#M/!r;ro!BYl7T`uuLJcbcLq>i\S!RUuF!<K_5!eLJ%nc:!;8HJqp._,W_nc:08!SIK'=b6^c""IFT!e!Io!pTf<!^hhHl2^rUl2cbD.2W*f#"4=MM?;H815Z.u!<P^l!Ye$0H.i9,UB0?T!_!.ll2^n8"mQ*i:BCUJ!^sHuiW0*V!WqKj7(EC$nc:08!RV!!=b6_>"tEdP!VuhK!^hP@\HXNdJcbcLq>gkR!kAOc=b6_O!Vug&Jc`1^.TlfS#"8:gJcbcL"+gU="tEdP!VuhK!b(a(q>gXn!Wn&[7/?r+#PnH%N</kVnc:EG!k\S&!YVL7%B9K8!<P^l)QEiJ!WjuB!ho_t/trDu!P&:PU&q"mklr-%!kAQ`"WRRF9gku_EWS_h"p1e+-qOKG![tS]!kJF]WWG!Y8HJqp.e3TI!_i.c!Wj"f!s4nm-isHu7)Aui!<P^l!pTeb!Wr<%6irMQ6;djdOoeP`!e^eHi<JQKiW<^1l2h#VdK8t@!_0Hsq>p^f!pTgg,oZ%M!_1lFncAk^!WiQoZ3'k(!_*7V!WjYdl2h#ViWAZP!_*4m:.35+d07r"$d&P8#20+dao]*UiW9M1!kAR$!Xmrkl2oB8B$(1K#3l6ti<JQKg&bm/!eCC;!Xf&2[/i\$!r;s"7KViV![RmL]`pk;JcZ!C!f@$t;At,g&n_i?!WkgmRK=[2)Nk.7B?UYP!<Q$u!bOh%nc8e<RfVdT!_)ATnc8e]!Wqon;\JX%!_*7f!>89Knc9A9!Wn&V6lPUs!_2GUq>gXe$IJm+!Xf&2AOHS$quoIiOod[B!WnMd;Z["G7(NF$j8qpT!i?)g!ic;'8"p'j!WkiK!kJF77KTjs!_3:nIRF7S!Wj\-!Q"m>7_/ZD!Wkik!n%,O7KUF.![[+4nc8e]!Wlt%MZKOR!_&gbWWE5kq>ml'!_*4mK`OU$!Q"m>7^<*<!Wkj&!n%,O7KNX>7%sao!Wki[!l>!?7KU.&!_3:n-:@n:nc;Yjnc:4<]E7X)!`&k!/k"\"_?'d.WWL<E!_0HsdK0J>!l>!?,m".-!CQtjU^'<)!SRPU7KNYF!E0%$oERe\!J1CL!B#H1T`uuLq>l0Lq>jUG!r;p!:BCSM6jf=bJcZ;eYlfjb$OV^pOoc!m!eLI\!Wl@i!WoG+6imFS#"5a8RN%tC$M"4t!<P`j!UL-G">'ZV-:ID*nc:cWnc:cQ7e-S[!P&:Q!WkMQ!Wl@iq>m8o.TlfSPlX:<$M"5_!AFQV/jtj'l2^rUiW8TN!_*7V!<PauT`Xcc$N^Am6imGW#=JUp!\3aA\cMq&\cMp7"i:;7!Wkgm!ho`p!WnSk6jh$?;@?B#.Td$D=pnM;,$52_"C_`GaT?2bC2,5#!WkhZU&isK!_2/M!Wl$s!pTet!nm\A#nK,7!<P[sW<13C$Ne`W!\ONU777L1!HJPTOTp+>H?q&C$5%jj$N^BA6jebU+q"ag!\+QbaTF:+1,:=]i<B?E-jobS643ie!\ONUm/]T^!Wj((#8.)4$Ln3:$N^B@7"PGk!@h1YYm-'d$]4tB!@h1Q!X;&L!KmHb9`gaa!\ToB_$;,'RK;(Ef`E,p!X;&]!SITq*1?oE#FPW5$CM'l!=Rij!ic8L$IJm[!=L-`!<P[k!j)MlW<<:f!@XZCnc8e]!r;p!/jb-k!_2/MM?3iK\H;nr!\!RD!h'0=!eLItB*&/2!?)"@Jc]Kbnc9F8z!!iSDncT!qV?''d!hKE\U'.2"RL]P3!s0r#!Wq3Z7,\=O.OZbJ!X1&/.OQ\q\H<l""Y(u]+t=d5!Wk8J,.Rdg#LN]!+ugbR+uCd[!u_D"\H<HL!WkJP,.Re*"<o<F-Ro0!"W@FD'G_Sg:BCT.6imE06mB/D&dQef+sJuj.O#-*.On7E+t=07.KWBI!_#KY.PqnB!\?_>z!s&J8ncT!q7RR:Z5"#GR%7C71Q2tFr!Ye%Z$3CP_$3C92!X\u]!WkhZ9*t_h!Wi^-)A3)[!WiQo&de[K$3C8;!WiEF!Wjo@T`Y?/-lN-g6(nA^+t+'D!_J7[l3*gu,mj]'+T_]b6i[2e!!!*%%'&k$!Wj-*!Wij"iWYJa3Z8>,!Yb\;$6B6M!^-Sd*(0c,!!!!'!<TLr"9JWW6imE:6imE27%se#&BY%k$5sgb)?KsD&cr+K!ZD+m,1-Vs=X"ak+X0bb=X"as+T_]j6i[2e!!!90#$hNm70P9\ncT!q[K/bt!j2PlU)S\%ndIB*OTd4;aTMZ#-lO92-3=6\6jbCF"p,,=;??n,)9E!_3[b%R,%gra!]'lb&lJcD1/\/l!\WF9![9&W!<O`!!WkJP![87T!\,Bl18t:(=TSY(6im]&;??n,*WcZ];??n(6imu>;?@aL;?A$d;??n>6imEa6i[2e!!!K0!fQXQ!Wqcl6imGP"%31lh?-1:(n)6*$sZu0"doQ7>58Ds#96p0!m(Tc!Wr?'7/6po!_n4I@TmB+"C_F,3FZ0(>1!Q5!?;.B^&g]+R0o>_*9dc=!_r1e@TmAI_$T?/*2s-O!_m-T#@\):#%CbJ!Wo5#7(EA.>%UsS#(Zms>/:BA!uq@D,Xg#\@Tm@W@KK!o"CbPH>)<?d!ZV7CNWDOOW<T$t**V#%#ooWE@KK7*!gWpV>-SBr"rt_k@KK9'!b,>F>/:L7!ZV7CecA27!b,>F>-S6.*!-1NAHDpu!CU,e"c3F'>,_\I!utHQ!_i^t77:=q!V$@6>*0))*2s6R!_q&K@Tm@F!gNdS=u#ON*9dQ7!_mrL>%Us3!T=8'!WmL4>*0,J"<:V0#iQ%/>$C_))d3:E'iG)7'EVG>/u]%a!_i^tZiNQud0Pj8*2s-O!_m.'#\"1P"CbPH!WppR6sAOP&KL$?@KK9'#@^kK\HQFD9o0*a>%Usk#E]00>(Ht$"rph2!r2j:klkMt9pl/o>%Urp"d&m,>*0&p!utLd!J(=m!WjuBfa)%jAm4-qYm)1OOUB23**T$Bd0CWm!d$h6f`f1o**T$=i;t!u#%@X.@c7K"$^h-,>%UsC!N?)>!WkbX>+#]m#om.-"[O,3M$_!"*.\E*!_p32@TmAIaU%D>*!-3>!CQnf!!!!,!<U./"9JXj!CQtjNWDQ5"hGVh*Y\YW!^0.R!_*4m;H!VuV?''d![7tu.KW$X1'0lG![^;J+p(6e#6HA'T`tQR-isH46sD\R7<:cs7=tV5!_!.l2FITJ!a;Q-$3Ep/JHlMiW<Nt:9bQCe&dnaB>XSVp%R^@",Xb7&!_-&h!YQJN!`&k!/OTR=!!!!0"\Ak@-'86(ncT!qV?''d!hKE\\H;mW-n59*6*UXr1+4?d!s2$q!`BA';BeIH;GnqF!X;%B.T//K),a^;;S`JV;MbHQ"B$EF7KNXG"%32g&lK?G!_,dk!_*4m1dob5RMhhA!X\u1'FNe'&dnaZ!`B($#"0(J!_*50!_9KuNWC%b!Wp@D6mBGK$<\8],!5o.c2g<o64-ge3k5>58kKFm;EE2/*E#cB=Ai<h=;"e0+X1)f.9]nA=CTYY$<[E3#"2p(8g+6;NWDNlT`PR()O1=I49>S]!CRPE!_*4m#"0XJ!_*4m'LWQ8+u^\Y!_*4m'LX,H&eb<J4[ef@*>1[?!aS1q!Wji$&ctN(!Ye$(,5hOO!Wj-*!]#E0@KHTo6imDk.KTYQ4TZf?;A(G\7_&U&1+32*#"6!(!]h_R+p')8)(Jl@._u6..Z"3V"=bSs7OkYE$<[E3#"6iB!\u/b!YRf0!s1e;!WiQo19CQY8HJsY!^m"g!!!!*!sK8OamoQ9!q$(W!WqKb7%t^=%)NHP1,=[f(c!Qj#Qcao;??n(6jbsV7\L"f67;m:1(#cd.L6(W`W8I/.M>W'1'0q%#Qd%8!WiQo!WjhY.Oq\/(]lH*;AqRt7Y(^E67;m:1(#clTaDVl.Ok]*!X;$o1(mIt3W_e@#m*FA!Wk+a!Wj?0!X]!,!YPi<\H;mO.(KN`+t+oJ,%grYA4.mK!X/W,777+U!!!!$!<B+i"9JW+>!iVu704)'56:ln;;r@s!r<rk!WiKmz!!WH9Wq$8o$3FEM!Wii5+p(XD!X;$o)B&p>%\a$Y*'s]."@N4i!!!!+!Z`0:ncT!qAjdge![]*8JI35$+sI9o.LK&d1'0r@#Qd%8!WiQonH]1_-n6DB-3>q0;A)"l7KNX76im\s;@3I,&cr[I;A'$4'"J)G)CPY2$;pp,#"0(R!_0^&!\u1O"9LV4!Wicu1'03Ei<IR..RF1<-:ECg!^\::!\t+n"#;Vk!WkMQ!WnA_6op_A.L4?)3]]5U3]]8f,2ihE6:)Rr3^Pkf3W]?d3W]?d1-4@u(ch^""Yr-t"rKB^i<C)"!]<Bo&s=9`!Ce9l#!*<%3W`(Y![^=o"u[Yl!WlXq\I#)5.RF1<4[_%d\H<[03oL8Z!WjE2\H;m_.,b@3)CPXgh#TnF3irDu!Wnnn6i[2e!!!K/ea`hE!lb:0!Wp(;7)AuA*r5t!$7\(a3]bXl(D8Jq-V@"Y"W%4A#"0A5d01@j)?NB#&ctN`$3EZu!kn\')DWKB1*Qch!Wl[r$IK#,";9)c1'ARP.PLo*-:A=V$<.'.^&^V/Ic1J_!Wp(:6lJ*1#Wa.27KNW26jbD!-SdI)"W&(Dd01?g!X;%Z)?NA`$3EZu!bFb4IGkA^!Wn#U6jenSi<Ck8![U5Y.KW'h!WiN,!\HeQ!Wj(H!s0Ahi<B?--isH%6kTh.7KNXu!CR:B"Y'X)[/o4j/HPui6i[2e!!!W7*>K_8TCW0e!mUg7!Wp@B6im^U"(D<57RR<($;pqW!>8:^!<N<8!f@!k;??n(6ir5H$>0Ed!_WRreceGC!WjhQ$49Z4&e\(T!Wiu9)?Ne<!X;$o)@C*Y!X_d+!WjhQ!qlX_!WiEQ!Wr?'7(EC$)CPq,!_Kp)!X^=W&ctrD!Wiu9!]<@IEY;8j!Wj#6"*+H=!WqKd7!^>'+Tc[&;?D.W;L/BG&d!Xc!`B)O!=EH@EWSl8$@6"[!X;$oJcQK^JcPoS&d!pk!`B)W!=EH@!dYc2.WQ[6!kn_(\H;n"-o.q.!_EGC!\WF9!\u/q!]h_2!]<@I!ephG!`BA'!a5Y'=ona<!b)4/!b)LL!`B(m!a5q/!Wmg=!b)4/!b)LL!`B(m!a5q/!b)4/@KHTD!bqd7!br'T!a5Xu=t3Dn!Wnnn6ip6n;?C#';Ha,'&cr,_6ipg!;IT\/&cueL;?CS?B*)6<93NfC+T_`D!CQuEmK$bu!i,ib!`JXk@KHV&!CR!8&lO#W!YPP9PQF5SEWT-Z!Wiu9H4j,%!Wj!\H7E"u!X;$oH4C\l![L0[.WQ[6EWT-Z!Wiu9!X;$oH4j,%!Wj"!!dXoD!Wnnn6imFs!CQtj!\1__!\u/*3W`2?!Wj"F!s1e;1A(YL8`9jT;CG*<=t$o`!b*QUK`V<I!]'EM@KHUB7'[Jh%`/hsz!"fQ("[+_O0c;,`EM)h*!Wqco6imGP#"/M:^&f&O![^;:)VtN2!a6dG!WlP(!Wp@C6iot);??nl;Z[%"!CR8m!_-@]"q"K`@KJtj+p%rM&el)_!fd:L!_OYL!^Zr]!_PdW!Wl@i3[+VP!^\Y?!_PLO!WiQo$;ppp=t7&b*FcP]1'[j^AOHS\.T-U?!_,d3\H<jM\H=Sl!Wm4,!Wo5&6ipO9;??o';Z["G6ip71;??nt;Z[#l"%;\odL>+SA4dKn"s!b+L'&1m!^/pQ3[.H'!]j6]!hB?[=sDo0*F_@o"s!b[8l>]l#"0)E!_+A[!_*6+![VS"i<C;(E_94RH3-PsJcPpB!ce>g!cgn23dLis6@o4>7KNX/6lLXX!_*63![Rng8lA9-!_*4mNWDNLEWRNgE_95-H3-QFJcPpB!WkPR!ce>g8oau&EWQ:G!ce>g!cgn26@&]&!Wn>^6iqB1,m&*Z;IXqR7V[MU!_*4mAOK^R!<P^lEWRNgE_955H3-Q6JcPpB!Wp%96rH))"s!b3,SgF_S,u([3[.H'!]j6]!lb7/!\1nb('4Q'!CS-""q"K7!YPhYd/aSW![87T$7Z*H178=R=TSXK$6fNQ&csO$;??nH6j`ts'ESmK;@4<D7KNX66jb[N7QQqA$<\8s)J9*QV#`sc!lY1.!_OY7!Wktm!Wj'(!]'*C('4R(!^m"g!!!!%!35Sm!WjE2!Wj-*)QFf]$N^A66imDk=oo<<56;H!,6.]D!!!Q5"^qj[a7BE8!p0PP!Wq3[7.LE%(ZH*@!WjhY.O$&[!\,*d)DV@`,!#cp!WmO5,!#cp,!l?#,"_o+!WiQo,#SJ3,$G%;,%:UC!a5Xq,%:UC!b)LL!^Zs$!\sgM3`,r]!Wnqq6u,*j73Y>*7Nt_37KPmpB*'gi90,oO=TSZu"@O/B!a,jC)Bg$`"9M^5&fMo3Ta(X%$5+7#!Wp@H6on0H=TU&S,m#P7;??pV"%4>"+p]A:8i]L9+uB?&Q30O=!=Als!YPPe)Nb+'=TTcS;??pn"@OFH)BgmT!_!/7&lJc\!\ONUV?K?hC)U^d63:d$1'1*0;$'l%.KUmt.N22'1'0oH!fd:L$5+7#)YjC8=X)5u!a,R+N<)Ek@KK"CC'$j+@KK%DC'$jKEWS]SH3-P;!hB?[!\+6t!\,*d)DV@`,!#cp,!l?#!Wk8J,!#cp,!l?#!Wk+a3`,r]!WjhY!WppT6qSXI2H$d]!a/DF;Dq^`!WlM.=s>j+66^%D1'1+R"Tg_5!WqKb6m>MQ>tS!e:dRc@-NX?)$3C:1!^mq^!_+@p!_+A#!_*4mL''gN&fMo3OT>Md$5+7#!Wqup6inh>,q?/$!a.!.,$6TE.Nnip#"15'"9M^].KW'hOTPYf1=6+(=Y^U>+T_]H4W<hl!a,jC)Bg$h"9M^-!hB?[!\+6t!\,*d)DV@`,!#cp!WpRI6m<6^+W:Xg=UGc[+WB;E!a,jC)Bf.`#"0C""p.p7&fMo3aTV`K$5+7#!Wo2!6kV6V7KNW8$3D[q;Aq:l7KNWb6n0B)+Ta,3;Aq:l7Nsl;=<^'57KNWH$9D#c=TSXE6m>5)7Nt_37Nu";7Toip&cr-)"@O0-!s2U4&fMo3_#jaA$5+7#)OUU-=TS[&"%31lliKQTz$3OiC@D).6!Wlt%!Wl[r6;\(m6372l!WiEQ![87T!WjQE!WiEd![8+`!WjW83^O`e$7/#$!Wj'(!X]!5!ZD+m![7\1!Wj8Y\H;mW-itk";DR23$<[Ek!^?`9!_^'+!\u/J6iorC*7>2b&7PV>!!!!-9QfY,mOc^KLdLL^AF&/<">S-sMb1]KeuBfM0&,5IGY/1NW(t)l.hL`7:aFs`3[5]2&3/i;'5FBDhipTn:IjT^;g3tp=)s*$%L$O0.;8J6?p<p?#<HW+UG%fNR0Mt8bFmens8W-!s8Sbks8W-!s8W+lY5eP%s8W-!T^`!]s8W-!s.K)cs8W-!s8Sb<s8W-!s8W,5(q@'iehk;Pr"q[c,"rF=>^oH2GN9J=MkKD9s8W-!s8Sb`s8W-!s8W+lo)Jais8W-!TE"rlz!2/f\s8W-!s8TeL;[Y%P,4>S6:MGO'J&s87(tCh&R"4Utq>^Kps8W-!TX4[us8W-!s.Ht's8W-!s8TeHh<'rVnVtjH]B[XWbqG<P*YfE_q#CBos8W-!T[j)Bs8W-!s.K>js8W-!s8SbUs8W-!s8W+ld/X.Gs8W-!T_/9as8W-!s.J?Ns8W-!s8SbVs8W-!s8W+lqu?]rs8W-!TYpg0s8W-!s.JZWs8W-!s8Sats8W-!s8W+l3<0$Ys8W-!T`"iis8W-!s1T)ZSsGcaiZ_BY#/3t,l:UI%^'@dIU$BMi2SKFA%67qof(Pd0s8W-!s8W,5"Ta;+/shCX!=o57$.n_N!WnYh6imFM!^m(kL&sck$0i,f%U/u9#"3J5![Mf;!DshW!WjlmECh-j!WjQd\H1(Y*!-1^AHME5$;q3t!jMb=8ciK@;?C>P=or1`@KL$@!X;%JC'%m+3W]Ke!Y.U"!bOh%!X;&5!WjWff`;C!EWQ:mE`i\gEWQ:dEkqdU!?;.BEb,=K%g)G*!WkCi,WZ!7!WkPR1'.Lk3XVP^)`[sl-isH56n2(9@lbe8"p+js!CQtj#"3J5!afs[0cY38![;Zi!LWs.!WmCRJdXU@7e$K\67>G-!_`XsD+"[1zzz!!$U2!!!B,!!!c7!!!'#z!!"_R!!"5D!!!'#!!!'#!!#Xl!!"eT!!!'#!!!!(!X&tGncT!qDF=O-Ajc\%?:4hr<^Zuj#"13J![KN=R0"?`!WjQ$.FA/9!Wk,g!ZDF<!=C"P@fe+]8-/i2;$%(+>Cci$$:4dq#"13J![KPc!Qb?^1'.M$1>r7B*!-0sASD2I]`B#Q!_aL6!X5;=ap-Q#1'[dZzzzz!"/c,!"Ju/!!<3$!!3-#!$M=B!#Yb:!!<3$!!!9*!5S..!WmO5!Wm7-!WiQo3W]@53r&fE!ZX6&![9[f!MKN6!WkDo$R,X@+p*T%08Tb)$j'.c!Wji"'/BVX1*S1k!WiEd!WiQo3W]@.3dI\**'+-&,!&"5*!-1&AHDo7=ona4AVgF#!kSJi!ZD,7)Nb(>$N^AD6imF,7/@pm'Y5/B"onW'zz#64`($31&+!WW3#(B=F8%fcS0!rr<$+TMKB)ZTj<!<<*"z!!<3$]=],0x5));if not J[0X52DC]then J[0X508b]=(-2661112297+((A.q[0X2]>>J[0x4128]>=A.q[0x004]and A.q[4]or A.q[2])<<J[16680]>>J[16680]));j=(-0XA+(((J[0X3180]~J[6302])-A.q[0X8]>J[6302]and J[16680]or J[0x56B2])>>J[16680]));(J)[0X52DC]=(j);else j=(J[21212]);end;else if j==109.0 then A:F(M);break;else j=A:f(M,J,j);end;end;end;(M)[24]=A.c;M[25]=A.c;(M)[0X1A]=function()local J,O,F=({M});F=A:Y(F);goto I;::_::;O=A:y(J,F);if O~=nil then return A.K(O);end;::e::;A:S();goto Q;::t::;A:e();goto _;::Q::;A:Z();goto t;::w::;A:_();goto e;::I::;F=J[1][0X8](J[1][20],J[1][16],J[0X1][16]);goto w;end;return j;end,E=function(A,A,j)j=-0X29+((j>>0x14)+A[0x5cB4]>>0X3|A[0X6083]);(A)[0Xc06]=j;return j;end,DI=function(A,A,j)A[6]=j;end,c=nil,XG=function(A)end,_I=function(A,A,j,M,J)j=M[0X1][0X23]();A=(J>>3);return j,A;end,CI=function(A,A,j,M)(A)[M]=M+j;end,v=function(A,A)(A)[0X1b]=(error);(A)[28]=(nil);A[29]=(nil);A[30]=(nil);end,TI=function(A,A,j)A=j[0X1][0X23]();return A;end,nI=function(A,A,j,M)A[j]=j-M;end,MG=(function(A)local j,M,J,O=({});O,J=A:r(j,O,J);local F;F,O=A:A(F,J,j,O);F,O=A:U(O,J,j,F);O=A:W(J,j,O);O=A:g(J,j,O);A:D(j,F);O=A:T(O,j,J);A:v(j);O=A:m(O,j,J);local S;O,S=A:TG(O,J,S,j);M,O=A:JG(F,O,S,j,J);return A.K(M);end),SI=function(A)end,J=function(A,A,j)A=j[3588];return A;end,mG=function(A,j,M,J,O)J=j();if not(not M[0X37C1])then O=M[0X37C1];else O=(-2+((M[22194]>A.q[4]and M[0x4f6A]or A.q[0x7])>>M[16680]|M[0X6C6E]<=M[27758]and A.q[0X2]or M[0X3267]));M[0X37C1]=(O);end;return J,O;end,R=function(A,A,j)A=j[10085];return A;end,n=function(A,A,j)j=(A[7287]);return j;end,x=function(A,A)A=0;return A;end,sI=function(A,j)j={nil,nil,A.c,nil,nil,nil,nil,A.c,nil,A.c,nil};return j;end,rG=function(A)end,yG=function(A,A,j,M)for J=1,j do(A)[J]=M[1][39]();end;end,k=function(A,A)do return{A};end;return nil;end,mI=function(A,A,j)j=A>>3;return j;end,w=string.char,KI=function(A,A,j,M)M[1][0x019][A]=j;end,O=function(A,A,j)A=0X76;if not(j[1][0X20])then else(j[1])[0X1E]=-j[1][5];end;return A;end,tG=function(A)end,wI=function(A,A,j)j=({[3]=A>>2,[0X1]=A&3});return j;end,QI=function(A,A,j,M)(M)[j]=A;end,_=function(A)end,EI=function(A,A,j,M,J)j=J[1][0X00f](M);A=J[0x1][15](M);return A,j;end,eG=function(A)end,GG=function(A,A,j,M)M[0X1][25]=({});A=(M[1][0X22]()-6983);j=nil;return j,A;end,VI=function(A,A,j,M)M=A[0X1][15](j);return M;end,II=function(A,A)A=(nil);return A;end,iI=function(A,A,j)A=nil;j=(nil);return A,j;end,I=function(A,A,j,M)A=107;(j[1])[20]=(M);return A;end,e=function(A)end,CG=string.gsub,DG=function(A,A,j)A[1][0X17]=A[1][0xF](j*3);end,P=table.unpack,V=function(A,A,j)A=j[0X73AD];return A;end,m=function(A,j,M,J)j=(117);repeat if not(j<=0X1.4p6)then if not(j>=117.0)then(M)[30]=(9007199254740992);break;else(M)[28]=({});if not(not J[18677])then j=(J[18677]);else(J)[17872]=-493502275717693337+((A.q[2]+J[22194]>>J[0X4128]~=J[0X56b2]and A.q[0x8]or A.q[4])<<J[0x508b]);(J)[0X5EEF]=-108+((j+J[0x4669]<A.q[0X7]and J[3078]or J[0X52DC])|J[30431]<=J[0X6083]and J[18025]or J[27758]);j=(6+((A.q[0x9]~J[16680])<<J[16680]~J[16680]>J[23732]and J[24707]or A.q[6]));J[18677]=j;end;end;else M[0x1D]=(function()local O,F={M};F=A:z(O);return A.K(F);end);if not(not J[32642])then j=(J[0X7f82]);else j=(-158362693+(((A.q[0x2]|A.q[7])+J[0X3180]~A.q[0X5])+J[29489]));(J)[0X7f82]=j;end;end;until false;M[31]=(nil);(M)[0X20]=(nil);M[0X21]=(nil);M[34]=nil;j=25;return j;end,q={35771,2661112328,2516838008,3407495099,2548929532,24866575,34142061,229804905,893410321},zI=function(A)return{};end,Z=function(A)end,XI=function(A,A,j,M)j=A[0X1][0XF](M);return j;end,PG=function(A,j,M,J,O,F,S,X,T,V,f,b,q)local P;(T)[0X7]=b;for Y=0x1,M do local M,U,Z,N,k;Z,M,U,k,N=A:ZI(M,k,V,Z,U,N);local _,e,t;_,k,Z,N,e,t=A:vI(Z,t,N,M,_,k,e,V);local M;P,M=A:aI(T,t,X,q,Z,j,f,N,U,b,V,M,e,k,Y,J,O);if P~=nil then return{A.K(P)};end;if _==0X1 then if V[1][0X18]then local j,J;J,j=A:HI(J,j);goto R;::D::;J=A:pI(j,T,J);goto G;::R::;j=A:oI(V,M,j);goto D;::G::;(j)[J+2]=(Y);j[J+3]=(2);else S[Y]=(V[1][0Xd][M]);end;elseif _==0x4 then(q)[Y]=(M);elseif _==6 then q[Y]=(Y+M);elseif _==5 then A:nI(q,Y,M);else if _==0X3 then k=(#V[0x1][0X17]);(V[1][23])[k+1]=(S);Z=(0x68);repeat if Z==0X1.AP6 then Z=A:qG(Y,Z,k,V);else if Z==39.0 then A:lG(M,V,k);break;end;end;until false;end;end;end;T[0X3]=F;return 54135;end,bI=function(A,A,j,M,J,O)J[1][0X17][A+1]=(M);(J[0X1][0X17])[A+2]=O;J[1][23][A+3]=(j);end,PI=function(A,A,j)A[5]=j[1][34]();end,cG=function(A,j,M)j=0x21+(A.q[8]>>M[20619]<<M[0X5eEf]~M[0X45D0]~M[21212]);(M)[20330]=(j);return j;end,gI=function(A,j,M,J,O,F,S,X,T,V,f)X=F[0X01][15](j);if F[0X1][0X1C]~=F[0X1][32]then else if not(F[1][0X15])then else(F[1])[0X5],F[1][38]=F[1][0X1C],F[0X1][0X26];return O,{},X;end;end;(V)[8]=J;O=(0X69);repeat if O<=3.0 then(V)[0xB]=(M);break;elseif O==0x1.A4P6 then O=52;V[0X2]=(S);else O=A:WI(V,f,O);end;until false;V[9]=(T);return O,nil,X;end,rI=function(A,A,j,M,J,O,F,S,X)j=X[1][15](A);J=nil;O=nil;F=nil;S=nil;M=nil;return j,F,M,O,S,J;end,IG=function(A)end,s=string,OI=function(A,A,j,M)(A)[M]=j;end,JG=function(A,j,M,J,O,F)local S,X,T=(function(...)return(...)();end);M=0X0055;while true do X,M,T=A:iG(j,J,T,F,M,O);if X==0x1BFa then break;else if X==nil then else return{A.K(X)},M;end;end;end;T=O[0X26](T,O[0X1c])(J,A.l,O[14],S,O[0X21],O[0X1A],O[29],A.q,O[0X15],O[38]);return{O[38](T,O[28])},M;end,M=function(A)end,EG=function(A)end,sG=function(A)end,BI=function(A)end,X=function(A,j,M,J)j[0XC]={};if not M[3078]then J=A:E(M,J);else J=(M[0XC06]);end;return J;end,jI=function(A,A,j,M)(M)[A]=(A+j);end,kI=function(A,j,M,J,O,F)J=(O[1][13][M]);j=(nil);O=89;while true do if O==0X1.64P6 then O,j=A:dI(O,J,j);else J[j+1]=F;break;end;end;return J,j;end,dG=table.move,RG=function(A,A,j,M,J)if not(A)then(j[0X1][0XD])[J]=(M);else(j[1][0Xd])[J]=({[0]=M});end;end,YI=function(A,j,M,J,O)j=M[1][0X1d]();if M[1][0X22]==J then else O=A:FI(j,O,J,M);end;return j,O;end,WI=function(A,A,j,M)M=3;(A)[0X1]=(j);return M;end,ZI=function(A,A,j,M,J,O,F)A=M[1][0x23]();O=A&0X7;J=(nil);F=(nil);j=(nil);return J,A,O,j,F;end,G='_\x5F\u{069}nde\x78',UI=function(A,A,j,M)M=j[0X1][0xf](A);return M;end,L=function(A,j,M,J,O)O=nil;for F=97,253,0X27 do if not(F>136.0)then if not(F>=0X1.1P7)then else end;else M,O,j=A:N(F,O,J,j,M);end;end;return M,O,j;end,H=function(A,A)A[37]=function(...)local j={A};local A=j[1][0X16]('\x23',...);if A==0 then return A,j[1][5];end;return A,{...};end;end,YG=function(A)end,HI=function(A,A,j)j=(nil);A=nil;return A,j;end,j=function(A,j,M)if not(M>=j[0X1][32])then else if j[1][0X15]~=j[0X1][28]then else local J=0x33;while true do if J==0X1.98p5 then J=A:O(J,j);else if J==118.0 then j[0X1][0XE]=(-(10==0X8A));break;end;end;end;end;return{M-j[0X1][30]};end;return 6052;end,AG=function(A)end,SG=function(A,A,j)A=(j[1][34]()-29701);return A;end,zG=function(A,j,M)local J;if M<69.0 then j[0X27],j[34]=-j[11],(-j[0xf]);else if not(M>0x1.6P4)then else J=A:vG();return{A.K(J)};end;end;return nil;end,xI=function(A)end,LG=string.sub,r=function(A,j,M,J)J=({});(j)[1]=nil;(j)[0X2]=(nil);j[0X3]=(nil);M=0X58;repeat if M==88.0 then(j)[0X1]=next;if not J[6302]then M=-1+((A.q[7]|A.q[0x8])>>(A.xG('>i8',"\0\x00\0\0\0\0\x00\17"))>>(A.xG(">i\x38","\0\0\0\0\u{00}\0\0\z  \18"))==A.q[9]and A.q[0X03]or M);(J)[0X189E]=(M);else M=A:B(J,M);end;else if M==87.0 then(j)[2]=A.P;if not J[10085]then J[12672]=0x29+(((A.q[0X9]&A.q[0X6])>>12<A.q[0X3]and A.q[1]or M)&J[0X189e]);(J)[0x76DF]=(-340622377877+(((M&A.q[0X4])<<10<=M and A.q[1]or A.q[0X2])<<7));M=-3407495025+(((A.q[2]<J[0x189E]and A.q[2]or A.q[6])>>4)+A.q[0x4]>J[0x189E]and A.q[0X4]or J[6302]);(J)[10085]=M;else M=A:R(M,J);end;else if M==0x1.28P6 then(j)[0X3]=(type);break;end;end;end;until false;return M,J;end,TG=function(A,j,M,J,O)local F;while true do if j==0X1.9P4 then O[31]=function()local S,X,T=({O});X,T=S[1][17]("<i\z \56",S[0X1][0X14],S[0x1][16]);S[0X1][0X010]=(T);return X;end;O[32]=4503599627370496;if not(not M[0X38F9])then j=M[0x38f9];else j=-51+(((M[30431]<=M[0X189e]and M[29613]or M[0X45d0])|A.q[4])+M[0X6C6e]~=M[0X45d0]and M[0x5Cb4]or M[6302]);(M)[14585]=j;end;else if j==36.0 then O[0X21]=function()local S,X,T,V={O};for f=52,0Xb4,0x37 do if f<162.0 and f>0X1.AP5 then S[0X1][0X10]=(V);elseif f<0X1.ACP6 then T,V=S[0X1][0X11]('<\100',S[0X001][20],S[1][0X10]);else if not(f>107.0)then else X=A:i(T);return A.K(X);end;end;end;end;if not(not M[0Xe04])then j=A:J(j,M);else j=(50+((M[0x52DC]-M[12903]>M[0X3267]and A.q[0X8]or M[0X73ad])|M[0X5cB4]>M[3226]and M[17872]or M[24303]));(M)[3588]=(j);end;else if j~=0x1.98p5 then else(O)[34]=(function()local S,X,T,V={O};X,V,T=A:C(X,T,V);if V~=0X3E then repeat local V;X,V,T=A:L(T,X,S,V);until(V&0X80)==0X0;return X;end;end);break;end;end;end;end;O[35]=nil;(O)[36]=(nil);O[0X0025]=nil;j=90;while true do F,j=A:p(O,j,M);if F==19039 then break;end;end;(O)[0X26]=(nil);(O)[39]=(nil);J=nil;j=16;repeat if j==16.0 then j=A:qI(O,M,j);else if j==0x1.78P5 then(O)[39]=(function()local F,S,X=({O});X=A:lI(X);goto W;::g::;A:PI(X,F);goto i;::W::;X=A:sI(X);goto g;::i::;local T,V,f,b;V,b,T,f=A:RI(T,X,f,F,V,b);local q,P,Y,U,Z,N;q,U,N,Y,Z,P=A:rI(f,q,N,P,Y,U,Z,F);goto h;A:AI();::c::;N,Z=A:EI(N,Z,f,F);goto r;::B::;U=A:XI(F,U,f);goto c;::p::;Y=A:UI(f,F,Y);goto B;::h::;P=A:VI(F,f,P);goto p;::r::;local k;b,S,k=A:gI(f,U,Y,b,F,N,k,Z,X,P);if S~=nil then return A.K(S);end;A:DI(X,q);goto L;::H::;T=A:eI(V,F,T);goto z;::E::;S=A:PG(Y,f,U,T,V,N,P,X,F,q,k,Z);if S==54135 then do goto H;end;else if S==nil then else return A.K(S);end;end;A:sG();::L::;A:tG();goto E;::z::;S=A:wG(X,F);return A.K(S);end);if not M[20330]then j=A:cG(j,M);else j=(M[20330]);end;else if j==0X1.08P6 then J=(function()local M,F,S=({O,O[26]});S,F=A:GG(F,S,M);goto m;::l::;A:QG(S,M);goto x;::m::;S=A:KG(F,S,M);goto l;::x::;local O,X;O,X=A:gG(M,X,F,O,S);goto n;::s::;A:DG(M,O);goto K;::o::;A:IG();goto y;::a::;A:fG();goto d;::C::;A:FG();goto u;::n::;A:YG();goto C;::K::;A:yG(X,O,M);goto v;::u::;O=A:SG(O,M);goto a;::d::;A:eG();goto o;::y::;X=A:ZG(X,M,O);goto s;::v::;local O;for T=108,405,0X38 do if T==0X14C then return O;elseif T==0X0114 then(M[0X1])[0X17]=A.c;(M[0X1])[25]=(nil);elseif T==108 then for V=0X1,#M[0X1][23],0X3 do if M[1][0XC]~=F then(M[1][0x17][V])[M[0X1][0x17][V+0x1]]=X[M[1][23][V+2]];end;end;else if T==220 then A:_G(M);else if T==0XA4 then if F==S then if M[0X1][0X1d]then return;end;else if M[0X1][9]==M[0x1][0X1e]then if M[1][36]then return 86;end;else if not(S)then else M[0x1][12][0x2]=M[1][0xd];(M[1][0XC])[0X3]=X;end;end;end;O=(X[M[1][0X22]()]);end;end;end;end;end);break;end;end;end;until false;return j,J;end,tI=function(A,A)A=(nil);return A;end,_G=function(A,A)A[0X1][13]=nil;end,t=string.byte,ZG=function(A,A,j,M)A=j[0X1][15](M);return A;end,p=function(A,j,M,J)if M==0X1.68p6 then(j)[0X23]=(function()local O,F,S={j};S=A:d(S);goto jT;::AT::;F=A:k(S);if F~=nil then return A.K(F);end;::jT::;A:M();goto JT;::MT::;F=A:j(O,S);if F==6052 then do goto AT;end;else if F~=nil then return A.K(F);end;end;::JT::;S=A:u(S,O);goto MT;end);if not J[0x4193]then(J)[22998]=(-0X17B6EB8+(((J[0X76Df]~J[3078]<J[0X76df]and J[0X4128]or J[0X189E])~=J[0X48f5]and J[16680]or J[0X45D0])+A.q[6]));M=-2526477442+(J[16680]<<J[20619]&A.q[5]~A.q[5]~A.q[0X6]);J[16787]=(M);else M=(J[16787]);end;else if M==113.0 then(j)[36]=function()local O,F,S=({j});S=A:b(S);goto ST;::OT::;F=A:h(S,O);if F==nil then else return A.K(F);end;::FT::;A:a(S,O);goto OT;::ST::;S=O[1][0x22]();goto FT;end;if not J[18237]then J[0x5f78]=-0X20A0E1B+((A.q[0X1]<<J[24303]~J[0X59D6])-J[24707]+A.q[0X7]);M=-32+(((J[0x6083]&A.q[0X9])<<J[0X5EEf]==A.q[0x9]and J[0X38F9]or J[0x3180])>>J[0x4128]);(J)[18237]=M;else M=(J[0X00473D]);end;else if M==28.0 then A:H(j);return 19039,M;end;end;end;return nil,M;end,N=function(A,A,j,M,J,O)if A<=175.0 then j=M[0X1][0X8](M[0X1][20],M[1][16],M[1][16]);else if not(A<253.0)then J=J+7;M[1][16]=(M[0X1][0X10]+1);else O=(O|((j&0X7f)<<J));end;end;return O,j,J;end,vG=function(A)return{};end,BG=function(A,A,j)A=(nil);j=nil;return A,j;end,b=function(A,A)A=nil;return A;end,vI=function(A,j,M,J,O,F,S,X,T)F=(nil);X=(nil);M=(nil);for V=0X00e,0X85,5 do if V>0x1.8P4 then X,M=A:_I(M,X,T,O);break;elseif V>14.0 and V<24.0 then J=(j&7);S=T[0x1][0X23]();else if V<0x1.3P4 then j=A:TI(j,T);else if V>0X1.3P4 and V<29.0 then F=S&0x7;end;end;end;end;return F,S,j,J,X,M;end,a=function(A,A,j)(j[1])[16]=(j[0X1][0X10]+A);end,u=function(A,A,j)A=j[0x1][34]();return A;end,eI=function(A,j,M,J)for O=0X1,M[0x1][29]()do local O;O=A:II(O);goto VT;::XT::;O,J=A:YI(O,M,j,J);goto fT;::TT::;A:yI();goto XT;::VT::;A:SI();goto TT;::fT::;J=(J+0X1);end;return J;end}):MG()(...);