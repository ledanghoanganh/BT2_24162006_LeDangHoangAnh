package baitap2.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.webapp.DispatchMode;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		super.applyCustomConfiguration(builder);
		// Buộc SiteMesh sử dụng INCLUDE thay vì FORWARD để tương thích hoàn toàn với Tomcat 11
		builder.setDispatchMode(DispatchMode.INCLUDE);
	}
}
