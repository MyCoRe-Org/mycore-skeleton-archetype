package ${package}.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrQuery.ORDER;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.mycore.solr.MCRSolrClientFactory;

@WebServlet(urlPatterns = "/show-objects-with-files")
public class ShowMCRObjectsWithFilesServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static Logger LOGGER = LogManager.getLogger();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		PrintWriter pw = resp.getWriter();
		pw.println("<html>");
		pw.println("  <head>");
		pw.println("    <meta charset=\"utf-8\">");
		pw.println("    <title>${projectName}: MyCoRe Objekte mit Dateianhang (Derivaten)</title>");
		pw.println("  </head>");
		pw.println("  <body>");
		pw.println("    <h2>${projectName}: MyCoRe Objekte mit Dateianhang (Derivaten)</h2>");
		outputData(pw);
		pw.println("  </body>");
		pw.println("</html>");
	}

	private void outputData(PrintWriter pw) {

		try {
			final SolrQuery query = new SolrQuery();
			query.setStart(0);
			query.setRows(100);
			query.setSort("modified", ORDER.desc);
			query.setQuery("objectType:simpledoc");

			final QueryResponse queryResponse = MCRSolrClientFactory.getMainSolrClient().query(query);

			pw.println("<p>" + queryResponse.getResults().getNumFound() + " Objekte im Repository.</p>");
			if (queryResponse.getResults().getNumFound() > 0) {
				pw.println("    <table>");
				pw.println("      <tr><th>MCRID</th><th>zuletzt geändert</th><th>enthält Dateien</th></tr>");
				for (SolrDocument doc : queryResponse.getResults()) {
					pw.print("      <tr>");
					pw.print("<td>" + doc.getFirstValue("id") + "</td>");
					pw.print("<td>von " + doc.getFirstValue("modifiedby"));
					pw.print(" am " + doc.getFirstValue("modified") + "</td>");
					pw.print("<td>" + ("true".equals(doc.getFirstValue("${rootArtifactId}.hasFiles").toString()) ? "ja" : "nein")
							+ "</td>");
					pw.println("      </tr>");
				}
				pw.println("    </table>");
			}
		} catch (SolrServerException | IOException e) {
			LOGGER.error("Error processing Solr query", e);

		}

	}

}
