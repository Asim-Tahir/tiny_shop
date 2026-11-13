import 'dart:core';

class ProductResponseData {
	int? id;
	String? name;
	String? tagline;
	String? description;
	String? price;
	String? currency;
	String? image;
	ProductSpecs? specs;

	ProductResponseData({this.id, this.name, this.tagline, this.description, this.price, this.currency, this.image, this.specs});

	ProductResponseData.fromJSON(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		tagline = json['tagline'];
		description = json['description'];
		price = json['price'];
		currency = json['currency'];
		image = json['image'];
		specs = json['specs'] != null ? ProductSpecs.fromJSON(json['specs']) : null;
	}

	Map<String, dynamic> toJSON() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['name'] = name;
		data['tagline'] = tagline;
		data['description'] = description;
		data['price'] = price;
		data['currency'] = currency;
		data['image'] = image;
		if (specs != null) {
      data['specs'] = specs!.toJSON();
    }
		return data;
	}
}

class ProductSpecs {
	String? chip;
	String? material;
	String? camera;
	String? display;
	String? battery;
	String? id;
	String? ports;
	String? weight;
	String? design;
	String? colors;
	String? screen;
	String? pencil;
	String? connectivity;
	String? phoneCase;
	String? brightness;
	String? gps;
	String? feature;
	String? carbon;
	String? os;
	String? control;
	String? audio;
	String? driver;
	String? cancellation;
	String? materials;
	String? home;
	String? sensing;
	String? size;

	ProductSpecs({this.chip, this.material, this.camera, this.display, this.battery, this.id, this.ports, this.weight, this.design, this.colors, this.screen, this.pencil, this.connectivity, this.phoneCase, this.brightness, this.gps, this.feature, this.carbon, this.os, this.control, this.audio, this.driver, this.cancellation, this.materials, this.home, this.sensing, this.size});

	ProductSpecs.fromJSON(Map<String, dynamic> json) {
		chip = json['chip'];
		material = json['material'];
		camera = json['camera'];
		display = json['display'];
		battery = json['battery'];
		id = json['id'];
		ports = json['ports'];
		weight = json['weight'];
		design = json['design'];
		colors = json['colors'];
		screen = json['screen'];
		pencil = json['pencil'];
		connectivity = json['connectivity'];
		phoneCase = json['case'];
		brightness = json['brightness'];
		gps = json['gps'];
		feature = json['feature'];
		carbon = json['carbon'];
		os = json['os'];
		control = json['control'];
		audio = json['audio'];
		driver = json['driver'];
		cancellation = json['cancellation'];
		materials = json['materials'];
		home = json['home'];
		sensing = json['sensing'];
		size = json['size'];
	}

	Map<String, dynamic> toJSON() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['chip'] = chip;
		data['material'] = material;
		data['camera'] = camera;
		data['display'] = display;
		data['battery'] = battery;
		data['id'] = id;
		data['ports'] = ports;
		data['weight'] = weight;
		data['design'] = design;
		data['colors'] = colors;
		data['screen'] = screen;
		data['pencil'] = pencil;
		data['connectivity'] = connectivity;
		data['case'] = phoneCase;
		data['brightness'] = brightness;
		data['gps'] = gps;
		data['feature'] = feature;
		data['carbon'] = carbon;
		data['os'] = os;
		data['control'] = control;
		data['audio'] = audio;
		data['driver'] = driver;
		data['cancellation'] = cancellation;
		data['materials'] = materials;
		data['home'] = home;
		data['sensing'] = sensing;
		data['size'] = size;
		return data;
	}
}

class ProductsResponse {
	String? status;
	ProductResponseMeta? meta;
	List<ProductResponseData>? data;

	ProductsResponse({this.status, this.meta, this.data});

	ProductsResponse.fromJSON(Map<String, dynamic> json) {
		status = json['status'];
		meta = json['meta'] != null ? ProductResponseMeta.fromJSON(json['meta']) : null;
		if (json['data'] != null) {
			data = <ProductResponseData>[];
			json['data'].forEach((v) { data!.add(ProductResponseData.fromJSON(v)); });
		}
	}

	Map<String, dynamic> toJSON() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['status'] = status;
		if (meta != null) {
      data['meta'] = meta!.toJSON();
    }
		if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJSON()).toList();
    }
		return data;
	}
}

class ProductResponseMeta {
	String? title;
	String? description;
	String? copyright;
	String? generated;
	int? count;

	ProductResponseMeta({this.title, this.description, this.copyright, this.generated, this.count});

	ProductResponseMeta.fromJSON(Map<String, dynamic> json) {
		title = json['title'];
		description = json['description'];
		copyright = json['copyright'];
		generated = json['generated'];
		count = json['count'];
	}

	Map<String, dynamic> toJSON() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['title'] = title;
		data['description'] = description;
		data['copyright'] = copyright;
		data['generated'] = generated;
		data['count'] = count;
		return data;
	}
}
